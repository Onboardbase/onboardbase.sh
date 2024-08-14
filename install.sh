#!/bin/bash

set -e -o pipefail

install_nodejs(){
  curl -sS https://raw.githubusercontent.com/Onboardbase/onboardbase.sh/main/install_nodejs.sh | bash - 
}

load_nvm(){
  NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

install_obb_cli(){
  load_nvm
  log "Installing OBB CLI via npm"
  npm install -g @onboardbase/cli >/dev/null 2>&1
  log "OBB CLI installed successfully with version: \"$(onboardbase -v)\""
}


is_cmd_installed(){
 command -v "$1" >/dev/null 2>&1;
}

log(){
    echo ">>>  $1"
}

configure_obb_cli_token(){
  log "Configuring onboardbase token"
  onboardbase config:set --token=$ONBOARDBASE_TOKEN --scope=/
}

configure_obb_cli_api_host(){
  log "Configuring onboardbase api host"
  onboardbase config:set --api-host=$ONBOARDBASE_API_HOST --scope=/
}


configure_obb_cli_dashboard_host(){
  log "Configuring onboardbase dashboard host"
  onboardbase config:set --dashboard-host=$DASHBOARD_HOST --scope=/
}

create_yml_file(){
  yml=$(cat <<EOF
api_key:
setup:
  project: $1
  environment: $2
secrets:
  local:
EOF
)
  file_path="$(pwd)/.onboardbase.yaml"

  echo -e "$yml" > $file_path
  log "OBB Setup YAML file written to $file_path"
}

# ========================
# Install Node and OBB CLI
# ========================

if is_cmd_installed onboardbase; 
then
  log "onboardbase is already installed with: \"$(onboardbase -v)\". Use \"sudo onbaordbase update\" to get the latest version.";
  exit 0;
fi

# ensures that nodejs is intalled
if ! is_cmd_installed node;
then
  install_nodejs;
else
  log "NodeJS \"$(node -v)\" is installed."
fi

install_obb_cli

# ========================
# Configure the CLI
# ========================

if [ -n "$ONBOARDBASE_TOKEN" ];
then
  configure_obb_cli_token;
fi


if [ -n "$ONBOARDBASE_API_HOST" ];
then
  configure_obb_cli_api_host;
fi


if [ -n "$ONBOARDBASE_DASHBOARD_HOST" ];
then
  configure_obb_cli_dashboard_host;
fi

if [ -n "$ONBOARDBASE_PROJECT" ] && [ -n "$ONBOARDBASE_ENVIRONMENT" ];
then
  create_yml_file $ONBOARDBASE_PROJECT $ONBOARDBASE_ENVIRONMENT;
fi

log "Done!!!"
