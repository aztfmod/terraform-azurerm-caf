#!/bin/sh

TFC_AGENT_TOKEN=${1}
TFC_ADDRESS=${2}
agent_prefix=${3}
num_agent=${4}
admin_user=${5}
rover_version="${6}"

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

function cleanup {
  echo "calling cleanup"

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
# When the number of agents is reduced, stop and delete the services.
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
  docker stop  $container && docker rm -f $container
  file="/etc/systemd/system/rover-$container.service"
  rm -rf $file
done

file="/etc/systemd/system/rover-*.service"
rm -rf $file

for agent_num in $(seq 1 ${num_agent}); do
  TFC_AGENT_NAME="$agent_prefix-$agent_num"

  docker create --name "$TFC_AGENT_NAME" -u "vscode" -e TFC_AGENT_TOKEN="$TFC_AGENT_TOKEN" -e TFC_AGENT_NAME="$TFC_AGENT_NAME" -e TFC_ADDRESS="$TFC_ADDRESS" -e TFC_AGENT_LOG_LEVEL='info' --stop-signal 'SIGINT' --stop-timeout 5 ${rover_version}

  # Create a service for each agent to restart them automatically on reboot
  sudo systemctl disable rover-$TFC_AGENT_NAME.service || true
  file="/etc/systemd/system/rover-$TFC_AGENT_NAME.service"
  sudo touch $file
  echo "[Unit]" | sudo tee $file > /dev/null
  echo "Description=Rover agents" | sudo tee -a $file > /dev/null
  echo "Requires=docker.service" | sudo tee -a $file > /dev/null
  echo "After=docker.service" | sudo tee -a $file > /dev/null
  echo "[Service]" | sudo tee -a $file > /dev/null
  # tfc agent handles properly the gracefull shutdown. Meaning if the agent fails the logs will be in the stopped container with the reason.
  echo "Restart=on-success" | sudo tee -a $file > /dev/null

  start="/usr/bin/docker start -a $TFC_AGENT_NAME"
  stop="/usr/bin/docker stop -t 10 $TFC_AGENT_NAME"

  echo "ExecStart=$start" | sudo tee -a $file > /dev/null
  echo "ExecStop=$stop" | sudo tee -a $file > /dev/null
  echo "[Install]" | sudo tee -a $file > /dev/null
  echo "WantedBy=default.target" | sudo tee -a $file > /dev/null


  sudo systemctl daemon-reload
  sudo systemctl enable rover-$TFC_AGENT_NAME.service
  sudo systemctl start rover-$TFC_AGENT_NAME.service
  sudo systemctl status rover-$TFC_AGENT_NAME.service
done

sudo systemctl enable docker.service
docker system prune -a -f