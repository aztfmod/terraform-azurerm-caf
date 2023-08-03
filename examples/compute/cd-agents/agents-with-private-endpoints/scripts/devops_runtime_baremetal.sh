#!/bin/sh

url=${1}
pat_token=${2}
agent_pool=${3}
agent_prefix=${4}
num_agent=${5}
admin_user=${6}
rover_version="${7}"

error() {
    local parent_lineno="$1"
    local message="$2"
    local code="${3:-1}"
    if [[ -n "$message" ]] ; then
        >&2 echo -e "\e[41mError on or near line ${parent_lineno}: ${message}; exiting with status ${code}\e[0m"
    else
        >&2 echo -e "\e[41mError on or near line ${parent_lineno}; exiting with status ${code}\e[0m"
    fi
    echo ""
    exit "${code}"
}


set -ETe
trap 'error ${LINENO}' ERR 1 2 3 6

echo "start"

echo "install Ubuntu packages"

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
export DEBIAN_FRONTEND=noninteractive
echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

apt-get update
apt-get install -y --no-install-recommends \
        ca-certificates \
        jq \
        apt-transport-https \
        docker.io \
        sudo

echo "Allowing agent to run docker"

usermod -aG docker ${admin_user}
systemctl daemon-reload
systemctl enable docker
service docker start
docker --version

# Pull rover base image
echo "Rover docker image ${rover_version}"
docker pull "${rover_version}" 2>/dev/null

# Remove all previous containers and let systemctl restatring them
# Preview to be fortified
containers=$(docker ps --format "{{.Names}}")
for container in $containers
do
  output=$(docker exec $container ps)
  if echo "$output" | grep -q -e "rover.sh"; then
    echo "String contains 'rover.sh'"
    echo "Waiting for process with 'rover' in command to complete in container: $container"
    # TODO: to be executed in the container
    # while kill -0 $pid >/dev/null 2>&1; do
    #   sleep 1
    # done
    echo "Process completed. Killing container: $container"
  fi
  echo "Stopping agent: ${container}"
  systemctl disable rover-$container.service || true
  docker exec -u vscode $container /bin/bash -c '/home/vscode/agent/config.sh remove --unattended && exit 250' || true
  docker rm -f $container
  file="/etc/systemd/system/rover-$container.service"
  rm -rf $file
done

file="/etc/systemd/system/rover-*.service"
rm -rf $file

echo "install VSTS Agent"

for agent_num in $(seq 1 ${num_agent}); do
  AGENT_NAME="$agent_prefix-$agent_num"
  docker rm -f "$AGENT_NAME" || true

  docker create --name "$AGENT_NAME" -u "vscode" -e VSTS_AGENT_INPUT_TOKEN="$pat_token" -e VSTS_AGENT_INPUT_AGENT="$AGENT_NAME" -e VSTS_AGENT_INPUT_URL="$url" -e VSTS_AGENT_INPUT_POOL=${agent_pool} ${rover_version}

  # Create a service for each agent to restart them automatically on reboot
  file="/etc/systemd/system/rover-$AGENT_NAME.service"
  sudo touch $file
  echo "[Unit]" | sudo tee $file > /dev/null
  echo "Description=Rover agents" | sudo tee -a $file > /dev/null
  echo "Requires=docker.service" | sudo tee -a $file > /dev/null
  echo "After=docker.service" | sudo tee -a $file > /dev/null
  echo "[Service]" | sudo tee -a $file > /dev/null
  # set to always to handle agent reconnection after a reboot of the underlying host vm.
  echo "Restart=always" | sudo tee -a $file > /dev/null

  start="/usr/bin/docker start -a $AGENT_NAME"
  stop="/usr/bin/docker exec -u vscode $AGENT_NAME /bin/bash -c '/home/vscode/agent/config.sh remove --unattended && exit 250'"

  echo "ExecStart=$start" | sudo tee -a $file > /dev/null
  echo "ExecStop=$stop" | sudo tee -a $file > /dev/null
  echo "SuccessExitStatus=250" | sudo tee -a $file > /dev/null
  echo "[Install]" | sudo tee -a $file > /dev/null
  echo "WantedBy=default.target" | sudo tee -a $file > /dev/null


  sudo systemctl daemon-reload
  sudo systemctl enable rover-$AGENT_NAME.service
  sudo systemctl start rover-$AGENT_NAME.service
  sudo systemctl status rover-$AGENT_NAME.service
done

sudo systemctl enable docker.service
docker system prune -a -f