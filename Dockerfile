FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm --needed \
        base-devel \
        git \
        sudo \
        wlroots \
        meson \
        ninja \
        cairo \
        glm \
        libjpeg \
        seatd \
        pango \
        wayland-protocols \
        glm \
        doctest \
        nlohmann-json \
        cmake \
        glibmm \
        iio-sensor-proxy \
        librsvg \
        boost \
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
