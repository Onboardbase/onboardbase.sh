
## Integrate Onboardbase on production machines

Our goal with this install script is to ease the setup time for getting Onboardbase running on an uninstalled machine.

Onboardbase offers local development support for front-end frameworks and various cloud services. This allows us to offer production support so people don't have to install integrations for their deployment platforms. It would inject Onboardbase into your compute: Azure/GCP/DO/AWS VMs.

### Usage
---
```bash

# apt-get upgrade && apt-get update -y && apt-get install -y curl
# yum install curl

curl -Ss https://files.onboardbase.com/install.sh | bash - && \
  source ~/.bashrc && \
  onboardbase -v
```
---

#### Supported Environment variables
The script supports these environment variables:
- `ONBOARDBASE_TOKEN`: This automatically authenticates the CLI globally, and gives a head start to pulling secrets from onboardbase
- `ONBOARDBASE_API_HOST`: If the CLI is to connect with a self-hosted version, this flag can point to where the API is running
- `ONBOARDBASE_DASHBOARD_HOST`: If the CLI is to connect with a self-hosted version, this flag can point to where the FRONTEND is running
- Both `ONBOARDBASE_PROJECT` and `ONBOARDBASE_ENVIRONMENT`: This creates a `.onboardbase.yaml` file in the current directory that this script runs from to store an onboardbase project config file that points to both the project and environment. such that after running the install.sh script, onboardbase secrets --env should list all the secrets in the project `$ONBOARDBASE_PROJECT` and envirnment `$ONBOARDBASE_ENVIRONMENT`

### How it works
The script installs nodejs, if not installed via nvm, before using npm to install Onboardbase.

### Supported OS
This script should work on:
- Linux

If you need any support for other OSs, please create an issue.
