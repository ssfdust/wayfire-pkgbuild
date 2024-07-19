FROM archlinux:latest

RUN gpgconf --kill all \
    && rm -rf /etc/pacman.d/gnupg \
    && pacman-key --init \
    && pacman-key --populate \
    && pacman -Syu --noconfirm \
    && pacman -S --noconfirm --needed \
        base-devel \
        boost \
        cairo \
        cmake \
        doctest \
        extra-cmake-modules \
        git \
        glib2-devel \
        glibmm \
        glm \
        glslang \
        gobject-introspection \
        gtk-layer-shell \
        gtkmm3 \
        iio-sensor-proxy \
        libdbusmenu-gtk3 \
        libdisplay-info \
        libglvnd \
        libinput \
        libjpeg \
        libliftoff \
        libpulse \
        librsvg \
        libxcb \
        libxkbcommon \
        meson \
        ninja \
        nlohmann-json \
        opengl-driver \
        pango \
        pixman \
        seatd \
        sudo \
        systemd-libs \
        vulkan-headers \
        vulkan-icd-loader \
        wayland-protocols \
        xcb-util-errors \
        xcb-util-renderutil \
        xcb-util-wm \
        xorg-xwayland \
    && useradd pkgbuilder -g wheel -u 1000 -m \
    && chown -R pkgbuilder:wheel /home/pkgbuilder \
    && mkdir -p /home/pkgbuilder/wayfire/packages \
    && sed -i "s/# \(%wheel.*NOPASSWD.*\)/\1/" /etc/sudoers \
    && rm -rf /var/cache/pacman/pkg/*
ADD . /home/pkgbuilder/wayfire
RUN chown -R pkgbuilder:wheel /home/pkgbuilder

VOLUME /home/pkgbuilder/wayfire/packages
WORKDIR /home/pkgbuilder/wayfire
USER pkgbuilder
ENTRYPOINT ["/home/pkgbuilder/wayfire/updatepkg.sh"]
