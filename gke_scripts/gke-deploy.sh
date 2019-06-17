#!/usr/bin/env bash

echo "GKE DEPLOY SCRIPT COMES HERE"

gcloud container clusters get-credentials "$GCLOUD_CLUSTER_NAME" --zone="$GCLOUD_ZONE"

$GCLOUD_HOME/bin/kubectl set image deployment $1 django=$2:$3
