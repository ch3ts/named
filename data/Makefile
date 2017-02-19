
VERSION=9.11.0-P1
DEBUG=yes
EXEC=bind
CFLAGS=-fno-strict-aliasing -static
DESTDIR=/data/build/$(EXEC)-$(VERSION)

all: $(EXEC)


bind: download build install package clean
	@echo "Installation termined."

download:
	wget -O /tmp/$(EXEC).tar.gz ftp://ftp.isc.org/isc/bind9/$(VERSION)/bind-$(VERSION).tar.gz

build: download
	@mkdir -p /data/$(EXEC)-$(VERSION)
	@mkdir -p /data/build/$(EXEC)-$(VERSION)/
	@chmod -R 0755 /data/ 
	
	tar -zxvf /tmp/$(EXEC).tar.gz -C /data/
	
	cd /data/$(EXEC)-$(VERSION) && CFLAGS="$(CFLAGS)" ./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc/bind \
		--localstatedir=/var \
		--enable-threads \
		--enable-largefile \
		--with-libtool \
		--enable-shared \
		--enable-static \
		--with-openssl=/usr \
		--with-gnu-ld \
		--with-dlz-postgres=no \
		--with-dlz-mysql=no \
		--with-dlz-bdb=yes \
		--with-dlz-filesystem=no \
		--with-dlz-stub=yes \
		--enable-seccomp

install: build
	make -C /data/$(EXEC)-$(VERSION) all
	make -C /data/$(EXEC)-$(VERSION) install DESTDIR=/data/build/$(EXEC)-$(VERSION)

package:
	cp -a /data/builder/* /data/build/$(EXEC)-$(VERSION)/
	cd /data/build/ && dpkg-deb --build $(EXEC)-$(VERSION)

.PHONY: clean

clean:
	rm -rf /data/$(EXEC)-$(VERSION)
	rm -rf /data/build/$(EXEC)-$(VERSION)
	
