#!/usr/bin/env bash

S3_BUCKET="terraform-state-file-29b3f79b30cd369f"
S3_PATH="output"
OUTPUT_DIR="output"
STAGE_DIR="root"

function main() {

  local action=""
  local stage=""
  local workspace=""

  while getopts ":a:e:s:" opt; do
    case "$opt" in
      a)
        action="$OPTARG"
        ;;
      e)
        workspace="$OPTARG"
        ;;
      s)
        stage="$OPTARG"
        ;;
      \?)
        echo "Invalid option: -$OPTARG"
        exit 1
        ;;
    esac
  done

  # Validate action and stage
  if [[ -z "$action" ]]; then
    echo "Error: Action is required."
    exit 1
  fi

  if [[ -z "$stage" ]]; then
    echo "Error: Stage is required."
    exit 1
  fi

  # Validate stage directory
  if [[ ! -d "${STAGE_DIR}/${stage}" ]]; then
    echo "Error: Stage '${stage}' does not exist."
    exit 1
  fi

  # Create download directory if it doesn't exist
  mkdir -p "${OUTPUT_DIR}"

  # Download files from S3
  aws s3 sync "s3://${S3_BUCKET}/${S3_PATH}" "${OUTPUT_DIR}"

  # Set Terraform working directory
  TERRAFORM_DIR="${STAGE_DIR}/${stage}"

  # Generate variable string for Terraform command
  VAR_FILES=""
  for file in "${OUTPUT_DIR}"/*/*.json; do
    VAR_FILES="${VAR_FILES} -var-file=$(pwd)/${file}"
  done

  # Run Terraform command based on action
  case "$action" in
    "apply")
      # Check if workspace exists
      if [[ -n "$workspace" ]] && ! workspace_exists "$workspace"; then
        echo "Error: Workspace '${workspace}' does not exist."
        exit 1
      fi

      TF_WORKSPACE="$workspace" terraform -chdir="${TERRAFORM_DIR}" apply ${VAR_FILES}
      ;;
    "init")
      terraform -chdir="${TERRAFORM_DIR}" init
      ;;
    "destroy")
      terraform -chdir="${TERRAFORM_DIR}" destroy
      ;;
    *)
      echo "Error: Invalid action '${action}'. Valid actions are 'apply', 'init', and 'destroy'."
      exit 1
      ;;
  esac
}

# Function to check if a workspace exists
function workspace_exists() {
  local workspace="$1"
  # Terraform workspace outputs a list of workspaces.
  # The active workspace will include a * in the line
  # Other workspaces will include one or more leading whitespaces.
  # The regex takes care of this
  terraform -chdir="${TERRAFORM_DIR}" workspace list | grep -q -E "^\s*\*?\s*${workspace}\s*$"
}

main "$@"