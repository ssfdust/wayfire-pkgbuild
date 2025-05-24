Wayfire Archlinux PKGBUILD Collection
=====================
This is my custom PKGBUILD collection to build wayfire from git. There're some problems with wayfire git group on AUR, such as missing make dependecies, outdated subprojects and the inconsistent indentation. 

Another major problem is that I have installed some plugins not owned to wayfire-plugins-extra-git and I have to re-compile them after all packages installed. That's why I have to create the repo.

Requirements
---------------------
* base-devel
* devtools (recommanded, optional)
* podman (optional)

Provides
---------------------
* wayfire
* wf-config
* wcm
* wf-shell
* wayfire-plugins-extra
* wayfire-plugins-unsupported
  * [firedecor](https://github.com/mntmn/Firedecor)
  * [wf-wallpaper](https://codeberg.org/Clyybber/wf-wallpaper/src/branch/wayfire08)

Installation
---------------------

### Complete Installation

```bash
./updatepkg.sh
```

### Partial Installation

#### List of Items

* wayfire-git (mini miniex full)
* wf-config-git (mini miniex full)
* wayfire-plugins-extra-git (miniex full )
* wayfire-plugins-unsupported (miniex full)
* wf-shell-git (full)
* wcm-git (ful)

#### Installation Mode

* mini
* miniex (default)
* full
* custom

#### Custom

`./updatepkg.sh <Mode>/<Item-name>`

#### Example

```bash
./updatepkg.sh mini
./updatepkg.sh wayfire-plugins-extra-git
```
