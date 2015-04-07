#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Page>
#include <bb/cascades/Window>
#include <bb/cascades/DevelopmentSupport>
#include <bb/ApplicationInfo>
#include <bb/device/HardwareInfo>

#include <Flurry.h>
#include <FlurryApiKey.h> //#define API_KEY = "ASDADASDASDASDASDASDASD"#include <QtCore>#include <QtNetwork>
#include <QtXml>
#include <Qt4/QtDeclarative/qdeclarativedebug.h>

#include "HashGenerator.hpp"
#include "FileSystemManager.hpp"
#include "LinkGenerator.hpp"
#include "SwLookup.hpp"
#include "Clipboard.hpp"
#include "timer.hpp"
#include "Settings.hpp"
#include "UpdateChecker.hpp"
#include "Nomedia.hpp"
#include "MetadataReader.hpp"
#include "PasteClient.hpp"
#include "FlurryAnalytics.hpp"

using namespace bb::cascades;

void myMessageOutput(QtMsgType type, const char* msg)
{
    Q_UNUSED(type);
    fprintf(stdout, "%s\n", msg);
    fflush(stdout);
}

Q_DECL_EXPORT int main(int argc, char **argv)

{
    Settings settings;

    qputenv("CASCADES_THEME",
            (settings.getValueFor("theme", "default") + "?primaryColor="
                    + settings.getValueFor("maincolor", "0x0092CC") + "&primaryBase="
                    + settings.getValueFor("basecolor", "0x087099")).toUtf8());

    Application app(argc, argv);

    settings.saveValueFor("appversion", bb::ApplicationInfo().version());

    bb::device::HardwareInfo hwinfo;
    settings.saveValueFor("uuid", hwinfo.pin());

#ifndef QT_NO_DEBUG
    qInstallMsgHandler(myMessageOutput);
#endif

    //Live QML, debug only
    DevelopmentSupport::install();

    //MD4/MD5/SHA-1
    HashGenerator hashgenerator;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_hashgen",
            &hashgenerator);

    //Text file in/out
    FileSystemManager manager;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_fsmanager",
            &manager);

    //Link generation
    LinkGenerator linkgen;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_linkgen",
            &linkgen);

    //Clipboard
    Clipboard clipboard;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Clipboard",
            &clipboard);

    //Software lookup
    SwLookup swlookup;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_swlookup",
            &swlookup);

    //QSettings
    //Declared already
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Settings",
            &settings);

    //Update checker
    UpdateChecker updatechecker;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Checker",
            &updatechecker);

    //Nomedia
    Nomedia nomedia;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Nomedia", &nomedia);

    //Momentics metadata
    MetadataReader metadata;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_metadata",
            &metadata);

    //Paste client
    PasteClient paster;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Paster", &paster);

    //Timer
    qmlRegisterType < QTimer > ("qt.timer", 1, 0, "QTimer");

    //Flurry
    FlurryAnalytics flurry;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Flurry", &flurry);
    Flurry::Analytics::SetSecureTransportEnabled(true); //use SSL
    if (settings.getValueFor("enableFlurry", "true") == "true") {
        Flurry::Analytics::StartSession(API_KEY);
    }
    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    ApplicationUI appui;

    // Enter the application main event loop.
    return Application::exec();
}
