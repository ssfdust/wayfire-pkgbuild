FROM archlinux:latest

ADD . /home/pkgbuilder
RUN pacman -Sy --noconfirm --needed \
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
    && useradd pkgbuilder -g wheel -u 1000 \
    && chown -R pkgbuilder:wheel /home/pkgbuilder \
    && mkdir -p /home/pkgbuilder/packages \
    && sed -i "s/# \(%wheel.*NOPASSWD.*\)/\1/" /etc/sudoers \
    && rm -rf /var/cache/pacman/pkg/*

VOLUME /home/pkgbuilder/packages
WORKDIR /home/pkgbuilder
USER pkgbuilder
ENTRYPOINT ["/home/pkgbuilder/updatepkg.sh"]
