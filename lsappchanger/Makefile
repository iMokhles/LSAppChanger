GO_EASY_ON_ME = 1

DEBUG = 0

ARCHS = armv7 armv7s arm64

THEOS_DEVICE_IP = 192.168.0.10

TARGET = iphone:clang:latest:10.0

export ADDITIONAL_LDFLAGS = -Wl,-segalign,4000

include theos/makefiles/common.mk

BUNDLE_NAME = LSAppChanger
LSAppChanger_FILES = LSAppChanger.mm
LSAppChanger_INSTALL_PATH = /Library/PreferenceBundles
LSAppChanger_FRAMEWORKS = UIKit
LSAppChanger_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LSAppChanger.plist$(ECHO_END)
