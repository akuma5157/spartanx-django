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
  curl "https://sdk.cloud.google.com" | bash > /dev/null
fi

. "$GCLOUD_PATH_APPLY"
gcloud version

gcloud config set disable_usage_reporting true
gcloud --quiet components update kubectl
