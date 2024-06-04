#!/usr/bin/env bash

S3_BUCKET="terraform-state-file-29b3f79b30cd369f"
S3_PATH="output"
OUTPUT_DIR="output"
STAGE_DIR="root"

# Get CLI arguments
ACTION="$1"
STAGE="$2"

# Validate stage directory
if [[ ! -d "${STAGE_DIR}/${STAGE}" ]]; then
  echo "Error: Stage '${STAGE}' does not exist."
  exit 1
fi

# Create download directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Download files from S3
aws s3 sync "s3://${S3_BUCKET}/${S3_PATH}" "${OUTPUT_DIR}"

# Set Terraform working directory
TERRAFORM_DIR="${STAGE_DIR}/${STAGE}"

# Generate variable string for Terraform command
VAR_FILES=""
for file in "${OUTPUT_DIR}"/*/*.json; do
  VAR_FILES="${VAR_FILES} -var-file=$(pwd)/${file}"
done

# Run Terraform command based on action
case "$ACTION" in
  "apply")
    terraform -chdir="${TERRAFORM_DIR}" apply ${VAR_FILES}
    ;;
  "init")
    terraform -chdir="${TERRAFORM_DIR}" init
    ;;
  "destroy")
    terraform -chdir="${TERRAFORM_DIR}" destroy
    ;;
  *)
    echo "Error: Invalid action '${ACTION}'. Valid actions are 'apply', 'init', and 'destroy'."
    exit 1
    ;;
esac