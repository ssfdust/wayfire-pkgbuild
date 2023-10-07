#!/bin/bash
set -e

dirlist=(wf-config-git wayfire-git wayfire-plugins-extra-git wayfire-plugins-unsupported-git)

if [ "$1" = "mini" ]
then
    dirlist=(wf-config-git wayfire-git)
elif [ "$1" = "full" ]
then
    dirlist=(wf-config-git wayfire-git wf-shell-git wcm-git wayfire-plugins-extra-git wayfire-plugins-unsupported-git)
elif [[ "$1" != "" && "$1" != "miniex" ]]
then
    dirlist=("$1")
fi

for dir in ${dirlist[@]}
do
    pushd "${dir}" > /dev/null
    if [ -f "PKGBUILD" ]; 
    then
        rm -rf pkg src "${dir}" "${dir%-git}" *.zst *.xz
        makepkg -s
        # find . -maxdepth 1 -type f -name "*debug*" -delete
        target=$(find -maxdepth 1 -regextype egrep -regex "./${dir}.*\.(xz|zst)" -printf "%f\n")
        sudo pacman --noconfirm -U ${target}
        rm -rf pkg src "${dir}" "${dir%-git}" *.zst *.xz
    fi
    popd
done
