#!/bin/bash -e

# Write JSON RPC secret file if provided
if [[ -n "$JSON_RPC_SECRET" ]]; then
  echo "$JSON_RPC_SECRET" > /etc/jamulus_rpc_secret.txt
fi

# Build the command as an array
CMD=(
  jamulus-headless -s -n
  -u "$JAMULUS_MAX_USERS"
  -p "$JAMULUS_PORT"
  -w "$SERVER_WELCOME_MESSAGE"
)

# Conditionally add JSON RPC flags if secret is set
if [[ -n "$JSON_RPC_SECRET" ]]; then
  CMD+=(
    --jsonrpcport 22222
    --jsonrpcsecretfile /etc/jamulus_rpc_secret.txt
    --jsonrpcbindip 0.0.0.0
  )
fi

# Directory mode: run as a directory server
if [[ "$DIRECTORY_MODE" == "1" ]]; then
  CMD+=(
    --directoryaddress localhost
    --serverinfo "$SERVER_NAME;$SERVER_LOCATION"
  )
  if [[ -n "$DIRECTORY_FILE" ]]; then
    CMD+=(--directoryfile "$DIRECTORY_FILE")
  fi
# Registered mode: register with an upstream directory
elif [[ -n "$SERVER_DIRECTORY" ]]; then
  CMD+=(
    --serverinfo "$SERVER_NAME;$SERVER_LOCATION"
    --directoryaddress "$SERVER_DIRECTORY"
  )
fi

# Conditionally add --enableipv6 for IPv6 if enabled
if [[ "$ENABLE_IPV6" == "1" ]]; then
  CMD+=(--enableipv6)
fi

# Conditionally add --delaypan if enabled
if [[ "$DELAY_PAN" == "1" ]]; then
  CMD+=(--delaypan)
fi

# Conditionally add -T for multithreading if enabled
if [[ "$MULTITHREADING" == "1" ]]; then
  CMD+=(-T)
fi

# Conditionally add --fastupdate if enabled
if [[ "$FASTUPDATE" == "1" ]]; then
  CMD+=(--fastupdate)
fi

exec "${CMD[@]}"
