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
  )
fi

# Conditionally add serverinfo and directoryserver if SERVER_DIRECTORY is set
if [[ -n "$SERVER_DIRECTORY" ]]; then
  CMD+=(
    --serverinfo "$SERVER_NAME;$SERVER_LOCATION"
    --directoryserver "$SERVER_DIRECTORY"
  )
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
