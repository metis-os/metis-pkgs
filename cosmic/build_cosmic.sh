#!/bin/bash

# Copyright (C) Pwnwriter // METIS Linux ( metislinux.org )

# vars
current_directory="$(pwd)"
directory_name="$(basename "$current_directory")"
last_character="$(basename "$(pwd)")"
package_directories=(`ls -d */ | cut -f1 -d'/'`)
packages_directory="$current_directory/pkgs-$last_character"

## Script Termination
exit_on_signal_SIGINT () {
    { printf "\n\n%s\n" "Script interrupted." 2>&1; echo; }
    exit 0
}

exit_on_signal_SIGTERM () {
    { printf "\n\n%s\n" "Script terminated." 2>&1; echo; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM



build_packages () {
    local package

    if [[ ! -d "$packages_directory" ]]; then
        mkdir -p "$packages_directory"
    fi

    echo -e "\nBuilding Packages - \n"
    for package in "${package_directories[@]}"; do
        echo -e "Building ${package}..."
        cd ${package}
        makepkg -scf
        mv *.pkg.tar.zst "$packages_directory"    

        set -- "$packages_directory"/${package}-*
        if [[ -e "$1" ]]; then
            echo -e "\nPackage '${package}' generated successfully.\n"
        else
            echo -e "\nFailed to build '${package}', Exiting...\n"
            exit 1;
        fi

        cd "$current_directory"
    done
}

build_packages

