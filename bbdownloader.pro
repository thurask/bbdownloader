APP_NAME = bbdownloader

CONFIG += qt warn_on cascades10

LIBS += -lbb -lbbsystem -lbbdata -lbbcascadespickers -lbbdevice

include(config.pri)

TRANSLATIONS = \
$${TARGET}_en.ts \
$${TARGET}_fr.ts \
$${TARGET}_.ts