#! /bin/bash

# common build scripts

# verify that all the passed arguments exist as environment variable
verifyMandatoryValues() {
    for envVariable in $* ; do
      : "${!envVariable?Required env variable $envVariable}"
    done
}

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



# This function checks if the file in the first argument $1 exists and is readable.
# If yes, then it prints the option supplied in the second argument $2 before the file path.
#
# Example:
#
# Given: $1="filename" | $2="-f" | the file with the path "filename" exists and is readable.
# Output: this function would print "-f filename"
execOptionIfFileExistsAndIsReadable() {
    if [ -r "$1" ]; then printf "%s %s" "$2" "$1"; fi
}

set -e
. "$(dirname "$0")/common.sh"

echo "Login to gcloud and select project"

# verify mandatory values
verifyMandatoryValues GCLOUD_PROJECT_ID GCLOUD_ZONE

# temporary file to store credentials from env variable value,
# because gcloud supports service account logging-in only from file
GCLOUD_CREDENTIALS="$PWD/travis-gke-client-secret.json"

# Auth, $GCLOUD_KEY must be set in Travis settings
gcloud auth activate-service-account --key-file "${GCLOUD_CREDENTIALS}"
gcloud config set project "$GCLOUD_PROJECT_ID"
gcloud config set compute/zone "$GCLOUD_ZONE"

echo "GKE DEPLOY SCRIPT COMES HERE"

gcloud container clusters get-credentials "$GCLOUD_CLUSTER_NAME" --zone="$GCLOUD_ZONE"

kubectl set image deployment $1 django=$2:$3
