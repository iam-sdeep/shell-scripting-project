#!/bin/bash

###############################################################################
## ABOUT:
# This script checks a GitHub repository and lists all users with read (pull) access.
# It uses GitHub's REST API v3 with basic authentication.
# Designed for repository administrators to audit access permissions.
#
#
## INPUT REQUIREMENTS:
# 1) Environment variables:
#    - $username: GitHub username for authentication
#    - $token: GitHub personal access token with 'repo' scope
# 2) Command-line arguments:
#    - $1: Repository owner (username or organization name)
#    - $2: Repository name
# 3) Dependencies:
#    - curl: For API requests
#    - jq: For JSON parsing
#
## OWNER: iam-sdeep
#
#
## If there is any issue feel free to contact owner.
###############################################################################

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

function helper {
    expected_cmd_args=2
    if [ $# -ne $expected_cmd_args ]; then
        echo "Please execute the script with required cmd args"
        echo "Usage: $0 <repo_owner> <repo_name>"
        exit 1
    fi
}

# Main script
helper "$@"
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
