all:
	./updatepkg.sh full

miniex:
	./updatepkg.sh miniex

mini:
	./updatepkg.sh mini

image:
	podman build -t ssfdust/wayfire-builder:$(shell date +%Y%m%d) .

podman-miniex:
	chmod 777 packages
	podman run --rm -it -v "$(shell pwd)/packages:/home/pkgbuilder/packages:z" ssfdust/wayfire-builder:$(shell date +%Y%m%d) miniex
	chmod 755 packages
