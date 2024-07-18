#!/bin/bash -e

# If running the rails server then create or migrate existing database
if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
  if ! ./bin/rails db:prepare; then
    echo "Failed to prepare the database"
    exit 1
  fi
fi

exec "${@}"