GO_EASY_ON_ME = 1

DEBUG = 0

ARCHS = armv7 armv7s arm64

THEOS_DEVICE_IP = 192.168.1.41

TARGET = iphone:clang:latest:10.0

export ADDITIONAL_LDFLAGS = -Wl,-segalign,4000

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = LSAppChanger
LSAppChanger_CFLAGS = -fobjc-arc
LSAppChanger_FILES = LSAppChanger.xm LSAppChangerHelper.m
LSAppChanger_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += lsappchanger
include $(THEOS_MAKE_PATH)/aggregate.mk
