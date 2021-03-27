include $(TOPDIR)/rules.mk

PKG_NAME:=overture
PKG_VERSION:=1.7
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://github.com/shawn1m/overture/archive/v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/shawn1m/overture/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=d3912fe53d2f6a60d20767a8dc5041333f8b5386b7d23d959b4de872d12b5024

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/shawn1m/overture
GO_PKG_BUILD_PKG:=$(GO_PKG)/main
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:=main.version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/overture
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=A customized DNS forwarder written in Go
  URL:=https://github.com/shawn1m/overture
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/overture/description
  Overture is a DNS server/forwarder/dispatcher written in Go.
endef

define Package/overture/conffiles
/etc/overture/
endef

define Package/overture/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/main $(1)/usr/sbin/overture
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/overture.init $(1)/etc/init.d/overture
	$(INSTALL_DIR) $(1)/etc/overture
	$(INSTALL_BIN) ./files/overture_update_ipnetwork_file.sh $(1)/etc/overture/overture_update_ipnetwork_file.sh
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/overture.config $(1)/etc/config/overture
	$(INSTALL_DIR) $(1)/etc/overture
	$(INSTALL_CONF) ./files/overture/* $(1)/etc/overture/
endef

$(eval $(call GoBinPackage,overture))
$(eval $(call BuildPackage,overture))
