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
        git \
        glib2-devel \
        glibmm \
        glm \
        gobject-introspection \
        gtk-layer-shell \
        gtkmm3 \
        iio-sensor-proxy \
        libdbusmenu-gtk3 \
        libjpeg \
        libpulse \
        librsvg \
        meson \
        ninja \
        nlohmann-json \
        pango \
        seatd \
        sudo \
        wayland-protocols \
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
