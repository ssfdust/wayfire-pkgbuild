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
* [wlroots-eglstream](https://github.com/danvd/wlroots-eglstreams) (for nvidia, xwayland doesn't work, all browsers are broken)

### custom wayfire-plugins-extra

The install script is using my own wayfire-plugins-extra repo, to catch update with some plugins, as well as additional plugins. if you care about it, please edit the PKGBUILD in wayfire-plugins-extra, refer the git url to the office repo.

Installation
---------------------

### Complete Installation

```bash
./updatepkg.sh
```

### Partial Installation

`./updatepkg.sh <Item-name>`

#### List of Items

* wayfire-git
* wayfire-plugins-extra-git
* wcm-git
* wf-config-git
* wf-shell-git
* wlroots-eglstreams-git (nvidia only)
* wlroots-git

#### Example

```bash
./updatepkg.sh wayfire-plugins-git
```
