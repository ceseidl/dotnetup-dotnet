#!/usr/bin/env bash
# Runs "dotnet --version" inside each case folder and prints
# what the global.json asked for and what dotnet answered.
cd "$(dirname "$0")/../cases" || exit 1

for dir in */; do
  dir=${dir%/}
  echo "[$dir] $(tr -d ' \r\n' < "$dir/global.json")"
  out=$(cd "$dir" && dotnet --version 2>&1)
  code=$?
  echo "  exit=$code"
  echo "$out" | sed 's/^ *//' | grep -m1 -E '^[0-9]|compatible' \
    | sed 's/^/  /'
done
