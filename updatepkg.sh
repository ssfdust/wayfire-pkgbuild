#!/bin/bash
if [ -n "$(lsmod | grep nvidia_drm)" ];then
    dirlist=(wlroots-eglstreams-git wf-config-git wayfire-git wf-shell-git wcm-git wayfire-plugins-extra-git)
else
    dirlist=(wlroots-git wf-config-git wayfire-git wf-shell-git wcm-git wayfire-plugins-extra-git)
fi

for dir in ${dirlist[@]}
do
    pushd "${dir}" > /dev/null
    if [ -f "PKGBUILD" ]; 
    then
        rm -rf pkg src "${dir}" "${dir%-git}" *.zst *.xz
        makepkg -s
        find . -maxdepth 1 -type f -name "*debug*" -delete
        target=$(find -maxdepth 1 -name "${dir}*.xz")
        if [ -f "${target}" ];then
            sudo pacman --noconfirm -U "${target}"
        fi
        target=$(find -maxdepth 1 -name "${dir}*.zst")
        if [ -f "${target}" ];then
            sudo pacman --noconfirm -U "${target}"
        fi
        rm -rf pkg src "${dir}" "${dir%-git}" *.zst *.xz
    fi
    popd
done
