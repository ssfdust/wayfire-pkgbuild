#!/bin/bash
set -e

dirlist=(wlroots-lily-git wf-config-git wayfire-git wayfire-plugins-extra-git wayfire-plugins-unsupported-git)

if [ "$1" = "mini" ]
then
    dirlist=(wlroots-lily-git wf-config-git wayfire-git)
elif [ "$1" = "full" ]
then
    dirlist=(wlroots-lily-git wf-config-git wayfire-git wf-shell-git wcm-git wayfire-plugins-extra-git wayfire-plugins-unsupported-git)
elif [[ "$1" != "" && "$1" != "miniex" ]]
then
    dirlist=("$1")
fi

if [ -d packages ]
then
    rm -rf packages/*
else
    mkdir -p packages
fi

TMPFS_DIR="/mnt/chroot-build/arch"
first_build=1

free_memory=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
free_memory_gb=$((free_memory / 1024 / 1024))

current_uid=$(id -u)
is_mounted=$(mount | grep "${TMPFS_DIR}" || true)

if [ "$current_uid" -eq 0 ] && [ -n "$is_mounted" ]; then
    echo "Deleting ${TMPFS_DIR} is still mounted, unmounting it"
    umount "${TMPFS_DIR}"
fi

rm -rf "${TMPFS_DIR}"

if [ "$free_memory_gb" -gt 8 ] && [ "$current_uid" -eq 0 ]; then
    buildroot="${TMPFS_DIR}"
    echo "Creating tmpfs for buildroot at ${buildroot}"
    mount --mkdir -t tmpfs -o defaults,size=6G tmpfs "${buildroot}"
else
    buildroot="/var/lib/archbuild/extra-x86_64"
fi

for dir in ${dirlist[@]}
do
    dir=${dir%/}
    pushd "${dir}" > /dev/null
    if [ -f "PKGBUILD" ]; 
    then
        rm -rf pkg src "${dir}" "${dir%-git}" *.zst *.xz *.log
        if command -v extra-x86_64-build;then
            if [ ${first_build} -eq 1 ];then
                first_build=0
                extra-x86_64-build -c -r "${buildroot}"
            else
                makechrootpkg -n -r "${buildroot}/extra-x86_64"
            fi
            find -maxdepth 1 -regextype egrep -regex "./${dir}.*\.(xz|zst)" -printf "%f\n" -exec cp -v {} ../packages \;
        else
            makepkg -s --noconfirm
            # find . -maxdepth 1 -type f -name "*debug*" -delete
            find -maxdepth 1 -regextype egrep -regex "./${dir}.*\.(xz|zst)" -printf "%f\n" -exec cp -v {} ../packages \;
            find -maxdepth 1 -regextype egrep -regex "./${dir}.*\.(xz|zst)" -printf "%f\n" -exec sudo pacman --noconfirm -U {} \;
        fi
        rm -rf pkg src "${dir}" "${dir%-git}" *.zst *.xz *.log
    fi
    popd
done

if [[ "${buildroot}" == "/mnt/chroot-build/arch" ]]; then
    echo "Unmounting tmpfs for buildroot"
    umount "${buildroot}"
    rm -rf "${buildroot}"
fi
