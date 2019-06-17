#!/usr/bin/env bash

echo "GCLOUD INSTALL SCRIPT HERE"

set -e

echo "Install gcloud SDK(if not cached yet)"

# verify mandatory values
. "$(dirname "$0")/common.sh"
verifyMandatoryValues GCLOUD_HOME GCLOUD_PATH_APPLY

if [ ! -f "$GCLOUD_PATH_APPLY" ]; then
  echo Installing gcloud SDK
  rm -rf "$GCLOUD_HOME"
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1 # SDK installation is interactive, thus prompts must be disabled
    # Add the Cloud SDK distribution URI as a package source
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    # Import the Google Cloud Platform public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

    # Update the package list and install the Cloud SDK
    sudo apt-get update && sudo apt-get install -y google-cloud-sdk
fi

. "$GCLOUD_PATH_APPLY"
gcloud version

gcloud config set disable_usage_reporting true
