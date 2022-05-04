#!/bin/bash
set -e

if [ -n "$(lsmod | grep nvidia_drm)" ];then
    dirlist=(wlroots-noassert-git wf-config-git wayfire-git wf-shell-git wcm-git wayfire-plugins-extra-git)
else
    dirlist=(wlroots-git wf-config-git wayfire-git wf-shell-git wcm-git wayfire-plugins-extra-git)
fi

if [ "$1" != "" ];then
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
