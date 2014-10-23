# Config.pri file version 2.0. Auto-generated by IDE. Any changes made by user will be lost!
BASEDIR = $$quote($$_PRO_FILE_PWD_)

device {
    CONFIG(debug, debug|release) {
        profile {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            LIBS += -lbbcascades \
                -lbbdevice \
                -lQtCore \
                -lQtXml \
                -lbbcascadespickers \
                -lclipboard \
                -lbbdata \
                -lbbsystem \
                -lQtNetwork

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        } else {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            LIBS += -lbbcascades \
                -lbbdevice \
                -lQtCore \
                -lQtXml \
                -lbbcascadespickers \
                -lclipboard \
                -lbbdata \
                -lbbsystem \
                -lQtNetwork

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }

    }

    CONFIG(release, debug|release) {
        !profile {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            LIBS += -lbbcascades \
                -lbbdevice \
                -lQtCore \
                -lQtXml \
                -lbbcascadespickers \
                -lclipboard \
                -lbbdata \
                -lbbsystem \
                -lQtNetwork

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

simulator {
    CONFIG(debug, debug|release) {
        !profile {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/bb/device) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtNetwork) \
                $$quote(${QNX_TARGET}/usr/include/bb/data) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtXml) \
                $$quote(${QNX_TARGET}/usr/include/bb/cascades/pickers) \
                $$quote(${QNX_TARGET}/usr/include/qt4/QtCore) \
                $$quote(${QNX_TARGET}/usr/include/bb/system)

            LIBS += -lbbcascades \
                -lbbdevice \
                -lQtCore \
                -lQtXml \
                -lbbcascadespickers \
                -lclipboard \
                -lbbdata \
                -lbbsystem \
                -lQtNetwork

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

config_pri_assets {
    OTHER_FILES += \
        $$quote($$BASEDIR/assets/10ppd/images/covers/cover.png) \
        $$quote($$BASEDIR/assets/12ppd/images/covers/cover.png) \
        $$quote($$BASEDIR/assets/12ppd/images/covers/cover_small.png) \
        $$quote($$BASEDIR/assets/8ppd/images/covers/cover.png) \
        $$quote($$BASEDIR/assets/9ppd/images/covers/cover.png) \
        $$quote($$BASEDIR/assets/ActiveFrame.qml) \
        $$quote($$BASEDIR/assets/AutoLookup.qml) \
        $$quote($$BASEDIR/assets/DeltaOSDownloader.qml) \
        $$quote($$BASEDIR/assets/DownloadComponent.qml) \
        $$quote($$BASEDIR/assets/EScreens.qml) \
        $$quote($$BASEDIR/assets/HardwareIDs.qml) \
        $$quote($$BASEDIR/assets/HashTools.qml) \
        $$quote($$BASEDIR/assets/HelpSheet.qml) \
        $$quote($$BASEDIR/assets/Nomedia.qml) \
        $$quote($$BASEDIR/assets/OSDownloader.qml) \
        $$quote($$BASEDIR/assets/OSRepo.qml) \
        $$quote($$BASEDIR/assets/ProgressBar.qml) \
        $$quote($$BASEDIR/assets/SettingsSheet.qml) \
        $$quote($$BASEDIR/assets/SysInfo.qml) \
        $$quote($$BASEDIR/assets/images/covers/cover.png) \
        $$quote($$BASEDIR/assets/images/covers/cover_small.png) \
        $$quote($$BASEDIR/assets/images/icons/icon_110.png) \
        $$quote($$BASEDIR/assets/images/icons/icon_144.png) \
        $$quote($$BASEDIR/assets/images/icons/icon_90.png) \
        $$quote($$BASEDIR/assets/images/icons/icon_96.png) \
        $$quote($$BASEDIR/assets/images/menus/ic_help.png) \
        $$quote($$BASEDIR/assets/images/menus/ic_settings.png) \
        $$quote($$BASEDIR/assets/images/menus/ic_show_vkb.png) \
        $$quote($$BASEDIR/assets/images/splash/aseries_landscape.png) \
        $$quote($$BASEDIR/assets/images/splash/aseries_portrait.png) \
        $$quote($$BASEDIR/assets/images/splash/lseries_landscape.png) \
        $$quote($$BASEDIR/assets/images/splash/lseries_portrait.png) \
        $$quote($$BASEDIR/assets/images/splash/nseries.png) \
        $$quote($$BASEDIR/assets/images/splash/wseries.png) \
        $$quote($$BASEDIR/assets/images/tabs/0.png) \
        $$quote($$BASEDIR/assets/images/tabs/1.png) \
        $$quote($$BASEDIR/assets/images/tabs/2.png) \
        $$quote($$BASEDIR/assets/images/tabs/3.png) \
        $$quote($$BASEDIR/assets/images/tabs/4.png) \
        $$quote($$BASEDIR/assets/images/tabs/5.png) \
        $$quote($$BASEDIR/assets/images/tabs/6.png) \
        $$quote($$BASEDIR/assets/images/tabs/7.png) \
        $$quote($$BASEDIR/assets/images/tabs/8.png) \
        $$quote($$BASEDIR/assets/images/tabs/9.png) \
        $$quote($$BASEDIR/assets/js/escreens.js) \
        $$quote($$BASEDIR/assets/main.qml) \
        $$quote($$BASEDIR/assets/xml/hwid.xml) \
        $$quote($$BASEDIR/assets/xml/repo.xml)
}

config_pri_source_group1 {
    SOURCES += \
        $$quote($$BASEDIR/src/Clipboard.cpp) \
        $$quote($$BASEDIR/src/DownloadManager.cpp) \
        $$quote($$BASEDIR/src/LinkGenerator.cpp) \
        $$quote($$BASEDIR/src/Nomedia.cpp) \
        $$quote($$BASEDIR/src/QmlBeam.cpp) \
        $$quote($$BASEDIR/src/Settings.cpp) \
        $$quote($$BASEDIR/src/SwLookup.cpp) \
        $$quote($$BASEDIR/src/UpdateChecker.cpp) \
        $$quote($$BASEDIR/src/applicationui.cpp) \
        $$quote($$BASEDIR/src/hashcalculatemd4.cpp) \
        $$quote($$BASEDIR/src/hashcalculatemd5.cpp) \
        $$quote($$BASEDIR/src/hashcalculatesha.cpp) \
        $$quote($$BASEDIR/src/main.cpp) \
        $$quote($$BASEDIR/src/timer.cpp)

    HEADERS += \
        $$quote($$BASEDIR/src/Clipboard.hpp) \
        $$quote($$BASEDIR/src/DownloadManager.hpp) \
        $$quote($$BASEDIR/src/LinkGenerator.hpp) \
        $$quote($$BASEDIR/src/Nomedia.hpp) \
        $$quote($$BASEDIR/src/QmlBeam.hpp) \
        $$quote($$BASEDIR/src/Settings.hpp) \
        $$quote($$BASEDIR/src/SwLookup.hpp) \
        $$quote($$BASEDIR/src/UpdateChecker.hpp) \
        $$quote($$BASEDIR/src/applicationui.hpp) \
        $$quote($$BASEDIR/src/hashcalculatemd4.hpp) \
        $$quote($$BASEDIR/src/hashcalculatemd5.hpp) \
        $$quote($$BASEDIR/src/hashcalculatesha.hpp) \
        $$quote($$BASEDIR/src/timer.hpp)
}

CONFIG += precompile_header

PRECOMPILED_HEADER = $$quote($$BASEDIR/precompiled.h)

lupdate_inclusion {
    SOURCES += \
        $$quote($$BASEDIR/../src/*.c) \
        $$quote($$BASEDIR/../src/*.c++) \
        $$quote($$BASEDIR/../src/*.cc) \
        $$quote($$BASEDIR/../src/*.cpp) \
        $$quote($$BASEDIR/../src/*.cxx) \
        $$quote($$BASEDIR/../assets/*.qml) \
        $$quote($$BASEDIR/../assets/*.js) \
        $$quote($$BASEDIR/../assets/*.qs) \
        $$quote($$BASEDIR/../assets/10ppd/*.qml) \
        $$quote($$BASEDIR/../assets/10ppd/*.js) \
        $$quote($$BASEDIR/../assets/10ppd/*.qs) \
        $$quote($$BASEDIR/../assets/10ppd/images/*.qml) \
        $$quote($$BASEDIR/../assets/10ppd/images/*.js) \
        $$quote($$BASEDIR/../assets/10ppd/images/*.qs) \
        $$quote($$BASEDIR/../assets/10ppd/images/covers/*.qml) \
        $$quote($$BASEDIR/../assets/10ppd/images/covers/*.js) \
        $$quote($$BASEDIR/../assets/10ppd/images/covers/*.qs) \
        $$quote($$BASEDIR/../assets/12ppd/*.qml) \
        $$quote($$BASEDIR/../assets/12ppd/*.js) \
        $$quote($$BASEDIR/../assets/12ppd/*.qs) \
        $$quote($$BASEDIR/../assets/12ppd/images/*.qml) \
        $$quote($$BASEDIR/../assets/12ppd/images/*.js) \
        $$quote($$BASEDIR/../assets/12ppd/images/*.qs) \
        $$quote($$BASEDIR/../assets/12ppd/images/covers/*.qml) \
        $$quote($$BASEDIR/../assets/12ppd/images/covers/*.js) \
        $$quote($$BASEDIR/../assets/12ppd/images/covers/*.qs) \
        $$quote($$BASEDIR/../assets/8ppd/*.qml) \
        $$quote($$BASEDIR/../assets/8ppd/*.js) \
        $$quote($$BASEDIR/../assets/8ppd/*.qs) \
        $$quote($$BASEDIR/../assets/8ppd/images/*.qml) \
        $$quote($$BASEDIR/../assets/8ppd/images/*.js) \
        $$quote($$BASEDIR/../assets/8ppd/images/*.qs) \
        $$quote($$BASEDIR/../assets/8ppd/images/covers/*.qml) \
        $$quote($$BASEDIR/../assets/8ppd/images/covers/*.js) \
        $$quote($$BASEDIR/../assets/8ppd/images/covers/*.qs) \
        $$quote($$BASEDIR/../assets/9ppd/*.qml) \
        $$quote($$BASEDIR/../assets/9ppd/*.js) \
        $$quote($$BASEDIR/../assets/9ppd/*.qs) \
        $$quote($$BASEDIR/../assets/9ppd/images/*.qml) \
        $$quote($$BASEDIR/../assets/9ppd/images/*.js) \
        $$quote($$BASEDIR/../assets/9ppd/images/*.qs) \
        $$quote($$BASEDIR/../assets/9ppd/images/covers/*.qml) \
        $$quote($$BASEDIR/../assets/9ppd/images/covers/*.js) \
        $$quote($$BASEDIR/../assets/9ppd/images/covers/*.qs) \
        $$quote($$BASEDIR/../assets/images/*.qml) \
        $$quote($$BASEDIR/../assets/images/*.js) \
        $$quote($$BASEDIR/../assets/images/*.qs) \
        $$quote($$BASEDIR/../assets/images/covers/*.qml) \
        $$quote($$BASEDIR/../assets/images/covers/*.js) \
        $$quote($$BASEDIR/../assets/images/covers/*.qs) \
        $$quote($$BASEDIR/../assets/images/icons/*.qml) \
        $$quote($$BASEDIR/../assets/images/icons/*.js) \
        $$quote($$BASEDIR/../assets/images/icons/*.qs) \
        $$quote($$BASEDIR/../assets/images/menus/*.qml) \
        $$quote($$BASEDIR/../assets/images/menus/*.js) \
        $$quote($$BASEDIR/../assets/images/menus/*.qs) \
        $$quote($$BASEDIR/../assets/images/splash/*.qml) \
        $$quote($$BASEDIR/../assets/images/splash/*.js) \
        $$quote($$BASEDIR/../assets/images/splash/*.qs) \
        $$quote($$BASEDIR/../assets/images/tabs/*.qml) \
        $$quote($$BASEDIR/../assets/images/tabs/*.js) \
        $$quote($$BASEDIR/../assets/images/tabs/*.qs) \
        $$quote($$BASEDIR/../assets/js/*.qml) \
        $$quote($$BASEDIR/../assets/js/*.js) \
        $$quote($$BASEDIR/../assets/js/*.qs) \
        $$quote($$BASEDIR/../assets/xml/*.qml) \
        $$quote($$BASEDIR/../assets/xml/*.js) \
        $$quote($$BASEDIR/../assets/xml/*.qs)

    HEADERS += \
        $$quote($$BASEDIR/../src/*.h) \
        $$quote($$BASEDIR/../src/*.h++) \
        $$quote($$BASEDIR/../src/*.hh) \
        $$quote($$BASEDIR/../src/*.hpp) \
        $$quote($$BASEDIR/../src/*.hxx)
}

TRANSLATIONS = $$quote($${TARGET}_en.ts) \
    $$quote($${TARGET}.ts)
