APP_NAME = bbdownloader

CONFIG += qt warn_on cascades10

LIBS += -lbb -lbbsystem -lbbdata -lbbplatform -lbbcascadespickers -lbbdevice -lscreen -lcrypto -lcurl -lpackageinfo

include(config.pri)

TRANSLATIONS = \
$${TARGET}_en.ts