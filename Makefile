include $(TOPDIR)/rules.mk
PKG_NAME:=amt
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/codarrenvelvindron/amt-openwrt/releases/download/1.1.1/
PKG_MD5SUM:=01733ee838de6abcf5e6fed2f7d191e5
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
define Package/amt-openwrt
  TITLE:=Automatic Multicast without Explicit Tunnels (AMT)
  CATEGORY:=Network
  DEPENDS:=+libevent-dev
endef

define Package/amt-openwrt/description
  AMT provides a way for a host, proxy, or router on a non-multicast
  capable network to join multicast groups on a remote multicast
  capable network through a relay on that network.
endef


define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
	CXX="$(TARGET_CROSS)g++"
endef

define Package/amt/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/amt $(1)/sbin/
endef

$(eval $(call BuildPackage,amt-openwrt))
