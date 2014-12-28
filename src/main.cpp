#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Page>
#include <bb/cascades/Window>
#include <bb/cascades/DevelopmentSupport>
#include <bb/ApplicationInfo>

#include <QtCore>
#include <QtNetwork>
#include <QtXml>
#include <Qt4/QtDeclarative/qdeclarativedebug.h>

#include "hashcalculatesha.hpp"
#include "hashcalculatemd5.hpp"
#include "hashcalculatemd4.hpp"
#include "DownloadManager.hpp"
#include "SwLookup.hpp"
#include "Clipboard.hpp"
#include "timer.hpp"
#include "Settings.hpp"
#include "UpdateChecker.hpp"
#include "Nomedia.hpp"
#include "MetadataReader.hpp"

using namespace bb::cascades;

QString getValue() {
    Settings settings;
    // use "theme" key for property showing what theme to use on application start
    return settings.getValueFor("theme", "");
}

void myMessageOutput(QtMsgType type, const char* msg) {
    Q_UNUSED(type);
    fprintf(stdout, "%s\n", msg);
    fflush(stdout);
}


Q_DECL_EXPORT int main(int argc, char **argv)

{

    qputenv("CASCADES_THEME", getValue().toUtf8());

    Application app(argc, argv);

#ifndef QT_NO_DEBUG
    qInstallMsgHandler(myMessageOutput);
#endif

    //Live QML
    DevelopmentSupport::install();

    //SHA-1
    HashCalculateSha*ihashcalcsha =  new HashCalculateSha();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("hashCalculateSha", ihashcalcsha);

    //MD5
    HashCalculateMd5*ihashcalcmd5 =  new HashCalculateMd5();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("hashCalculateMd5", ihashcalcmd5);

    //MD4
    HashCalculateMd4*ihashcalcmd4 =  new HashCalculateMd4();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("hashCalculateMd4", ihashcalcmd4);

    //File downloader
    DownloadManager manager;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_manager", &manager);

    //Clipboard
    Clipboard *clipboard = new Clipboard();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Clipboard", clipboard);

    //Software lookup
    SwLookup swlookup;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_swlookup", &swlookup);

    //QSettings
    Settings *settings = new Settings();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Settings", settings);

    //Update checker
    UpdateChecker *updatechecker = new UpdateChecker();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Checker", updatechecker);

    //Nomedia
    Nomedia nomedia;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Nomedia", &nomedia);

    //Momentics metadata
    MetadataReader metadata;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_metadata", &metadata);

    //Timer
    qmlRegisterType<QTimer>("qt.timer", 1, 0, "QTimer");

    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    ApplicationUI appui;

    // Enter the application main event loop.
    return Application::exec();
}
