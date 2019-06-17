#! /bin/bash

set -e
. "$(dirname "$0")/common.sh"

echo "Login to gcloud and select project"

# GCLOUD_KEY expected to be exported as JSON string in Travis settings
# don't forget single quotes around the value (like:
# '{"key":"val"}'
# )

# verify mandatory values
verifyMandatoryValues GCLOUD_KEY GCLOUD_PROJECT_ID GCLOUD_ZONE

# temporary file to store credentials from env variable value,
# because gcloud supports service account logging-in only from file
GCLOUD_CREDENTIALS="$PWD/travis-gke-client-secret.json"

# Auth, $GCLOUD_KEY must be set in Travis settings
gcloud auth activate-service-account --key-file "${GCLOUD_CREDENTIALS}"
gcloud config set project "$GCLOUD_PROJECT_ID"
gcloud config set compute/zone "$GCLOUD_ZONE"
