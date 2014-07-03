#include "applicationui.hpp"
#include "QmlBeam.hpp"

#include <bb/cascades/Application>
#include <bb/ApplicationInfo>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
QObject()
{

    // get app version without hardcoding
    bb::ApplicationInfo appInfo;
    QString versionNumber = appInfo.version();
    QDeclarativePropertyMap* appProperties = new QDeclarativePropertyMap;
    appProperties->insert("name", QVariant(appInfo.title()));
    appProperties->insert("version", QVariant(appInfo.version()));
    appProperties->insert("description", QVariant(appInfo.description()));

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("AppInfo", appProperties);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    new QmlBeam(this);

}
