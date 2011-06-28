include theos/makefiles/common.mk

TWEAK_NAME = BulletinBoardActivator
BulletinBoardActivator_FILES = Tweak.xm
BulletinBoardActivator_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
