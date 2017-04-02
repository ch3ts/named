
ifndef BIND_VERSION
	BIND_VERSION=9.11.0-P1
endif

DEBUG=yes
EXEC=bind
CFLAGS=-fno-strict-aliasing -static
DESTDIR=/data/build/$(EXEC)-$(BIND_VERSION)

all: $(EXEC)


bind: download build install package clean
	@echo "Installation termined."

download:
	wget -O /tmp/$(EXEC).tar.gz ftp://ftp.isc.org/isc/bind9/$(BIND_VERSION)/bind-$(BIND_VERSION).tar.gz

build: download
	@mkdir -p /data/$(EXEC)-$(BIND_VERSION)
	@mkdir -p /data/build/$(EXEC)-$(BIND_VERSION)/
	@chmod -R 0755 /data/ 
	
	tar -zxvf /tmp/$(EXEC).tar.gz -C /data/
	
	cd /data/$(EXEC)-$(BIND_VERSION) && CFLAGS="$(CFLAGS)" ./configure --prefix=/usr \
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
	make -C /data/$(EXEC)-$(BIND_VERSION) all
	make -C /data/$(EXEC)-$(BIND_VERSION) install DESTDIR=/data/build/$(EXEC)-$(BIND_VERSION)

package:
	cp -rv /data/builder/* /data/build/$(EXEC)-$(BIND_VERSION)/
	cd /data/build/ && dpkg-deb --build $(EXEC)-$(BIND_VERSION)

.PHONY: clean

clean:
	rm -rf /data/$(EXEC)-$(BIND_VERSION)
	rm -rf /data/build/$(EXEC)-$(BIND_VERSION)
	
