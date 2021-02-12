ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
export FINALPACKAGE = 1


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = popnotification

popnotification_FILES = src/Tweak/Tweak.m
popnotification_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
