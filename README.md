# Shell-Scripting-Project

This script lists all users with read access to a specified GitHub repository using the GitHub API.

## Description

The script performs the following actions:
1. Authenticates with the GitHub API using your username and personal access token
2. Takes a repository owner and repository name as command line arguments
3. Fetches and displays all collaborators who have read (pull) access to the repository

## Prerequisites

- Bash shell
- `curl` installed
- `jq` installed (for JSON processing)
- GitHub personal access token with appropriate permissions

## Setup

1. Set environment variables for your GitHub credentials:
   ```bash
   export username="your_github_username"
   export token="your_github_personal_access_token"
   ```

## Usage

Run the script with the repository owner and name as arguments:
```bash
./list-users.sh <repo_owner> <repo_name>
```

Example:
```bash
./list-users.sh octocat Hello-World
```

## Output

The script will output:
- A list of users with read access to the repository
- Or a message if no users with read access are found

## Error Handling

The script includes basic error handling:
- Checks for the required command line arguments
- Provides a usage message if arguments are missing

## Security Note

- Keep your personal access token secure
- Never commit tokens to version control
- Use tokens with the minimum required permissions
