Wayfire Archlinux PKGBUILD Collection
=====================
This is my custom PKGBUILD collection to build wayfire from git. There're some problems with wayfire git group on AUR, such as missing make dependecies, outdated subprojects and the inconsistent indentation. 

Another major problem is that I have installed some plugins not owned to wayfire-plugins-extra-git and I have to re-compile them after all packages installed. That's why I have to create the repo.

Provides
---------------------
* wlroots
* wayfire
* wf-config
* wcm
* wf-shell
* wayfire-plugins-extra
    * dbus-plugin
    * windeco
    * wayfire-shadows
    * [wf-wallpaper](https://github.com/DankBSD/wf-wallpaper)
* [wlroots-eglstream](https://github.com/danvd/wlroots-eglstreams) (for nvidia, xwayland doesn't work, all broswers are broken)

Installation
---------------------
```
bash ./updatepkg.sh
```
