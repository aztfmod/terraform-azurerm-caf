package main

import (
	"io/ioutil"
	"log"
	"net/http"
	"regexp"
	"strings"
)

func getLatestVersion() (string, error) {
	resp, err := http.Get("https://api.github.com/repos/hashicorp/terraform-provider-azurerm/releases/latest")
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	versionRegex := regexp.MustCompile(`"tag_name"\s*:\s*"v?(.*?)"`)
	match := versionRegex.FindStringSubmatch(string(body))
	if len(match) < 2 {
		return "", nil
	}

	return match[1], nil
}

func updateVersion(filename, currentVersion, newVersion string) error {
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		return err
	}

	updatedContent := strings.ReplaceAll(string(content), currentVersion, newVersion)

	err = ioutil.WriteFile(filename, []byte(updatedContent), 0644)
	if err != nil {
		return err
	}

	return nil
}

func main() {
	filename := "main.tf"
	currentVersionRegex := regexp.MustCompile(`version\s*=\s*"~>\s*v?(\d+\.\d+\.\d+)"`)

	content, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatal(err)
	}

	matches := currentVersionRegex.FindStringSubmatch(string(content))
	if len(matches) < 2 {
		log.Fatal("No azurerm provider version found in the file.")
	}

	currentVersion := matches[1]
	latestVersion, err := getLatestVersion()
	if err != nil {
		log.Fatal("Failed to retrieve the latest version from GitHub releases.")
	}

	err = updateVersion(filename, currentVersion, latestVersion)
	if err != nil {
		log.Fatal(err)
	}

	log.Printf("Successfully updated azurerm provider version from %s to %s.", currentVersion, latestVersion)
}
