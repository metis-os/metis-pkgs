#!/bin/sh

## Copyright (C) Pwnwriter // METIS Linux 

# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Please provide an argument: andromeda, cosmic, recon, or all."
  exit 1
fi

# Repos
directories=("andromeda" "cosmic" "recon")

# build the scripts in a directory
build_scripts() {
  dir="$1"
  script_name="build_${dir}.sh"

  # Check if the build script exists
  if [ -f "${dir}/${script_name}" ]; then
    echo "Building ${dir}..."
    (cd "${dir}" && "./${script_name}")
  else
    echo "Build script ${script_name} not found in ${dir}."
  fi
}

# Process the argument
case "$1" in
  "andromeda")
    build_scripts "andromeda"
    ;;
  "cosmic")
    build_scripts "cosmic"
    ;;
  "recon")
    build_scripts "recon"
    ;;
  "all")
    for dir in "${directories[@]}"; do
      build_scripts "$dir"
    done
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Valid arguments are: andromeda, cosmic, recon, or all."
    exit 1
    ;;
esac

echo "Build process completed...."


