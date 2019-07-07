# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: Makefile 5232 2006-10-19 15:25:58Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=libuuid
PKG_VERSION:=1.0.4
PKG_RELEASE:=1


PKG_CAT:=zcat

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-install

include $(INCLUDE_DIR)/package.mk

define Package/libuuid
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Lib uuid
  DESCRIPTION:=\
	This package contains a system-independent library for user-level \\\
	network packet capture.
  URL:=http://www.tcpdump.org/
endef

define Package/uuidgen
$(call Package/libuuid/Default)
  TITLE:=create a new UUID value
  DEPENDS:= +libuuid
endef

define Package/uuidgen/description
 The uuidgen program creates (and prints) a new universally unique identifier
 (UUID) using the libuuid library. The new UUID can reasonably be considered
 unique among all UUIDs created on the local system, and among UUIDs created on
 other systems in the past and in the future.
endef

define Build/Prepare
	rmdir $(PKG_BUILD_DIR)
	ln -s ${PWD}/$(PKG_NAME)/src-$(PKG_VERSION) $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && ./autogen.sh && chmod 777 configure
endef


define Build/Configure
	(cd $(PKG_BUILD_DIR); rm -f config.cache; \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		CPPFLAGS="-I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/include" \
		LDFLAGS="-L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/lib" \
		./configure \
			--target=$(GNU_TARGET_NAME) \
			--host=$(GNU_TARGET_NAME) \
			--build=$(GNU_HOST_NAME) \
			--program-prefix="" \
			--program-suffix="" \
			--prefix=/usr \
			--exec-prefix=/usr \
			--bindir=/usr/bin \
			--datadir=/usr/share \
			--includedir=/usr/include \
			--infodir=/usr/share/info \
			--libdir=/usr/lib \
			--libexecdir=/usr/lib \
			--localstatedir=/var \
			--mandir=/usr/share/man \
			--sbindir=/usr/sbin \
			--sysconfdir=/etc \
	);
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CCOPT="$(TARGET_CFLAGS) " \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/Clean
	rm -rf $(PKG_BUILD_DIR)/ipkg
	rm -rf $(PKG_BUILD_DIR)/ipkg-install
	rm -rf $(PKG_BUILD_DIR)
	$(MAKE) distclean
	cd src-$(PKG_VERSION); ./antigen.sh; cd -
endef

define Build/InstallDev
	mkdir -p $(STAGING_DIR)/usr/include/uuid
	$(CP)	$(PKG_BUILD_DIR)/uuid.h \
		$(STAGING_DIR)/usr/include/uuid
	mkdir -p $(STAGING_DIR)/usr/lib
	$(CP)	$(PKG_INSTALL_DIR)/usr/lib/libuuid.{a,so*} \
		$(STAGING_DIR)/usr/lib/
endef

define Build/UninstallDev
endef

define Package/libuuid/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libuuid.so.* $(1)/usr/lib/
endef

define Package/uuidgen/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/uuidgen $(1)/usr/bin/
endef

$(eval $(call BuildPackage,libuuid))
$(eval $(call BuildPackage,uuidgen))
