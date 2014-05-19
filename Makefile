ARCHS = armv7 arm64

include theos/makefiles/common.mk

APPLICATION_NAME = MobileTSS
MobileTSS_FILES = main.m MTAppDelegate.m MTAllFirmwaresTableViewController.m MTMyDeviceTableViewController.m MTSearchTableViewController.m
MobileTSS_FRAMEWORKS = UIKit CoreGraphics
MobileTSS_CFLAGS = -fobjc-arc
MobileTSS_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/application.mk

after-stage::
	$(ECHO_NOTHING)mkdir -p ./_/DEBIAN/$(ECHO_END)
	$(ECHO_NOTHING)cp -r postinst ./_/DEBIAN/postinst$(ECHO_END)