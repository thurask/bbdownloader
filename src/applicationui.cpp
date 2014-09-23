#include "applicationui.hpp"
#include "QmlBeam.hpp"
#include "UpdateChecker.hpp"

#include <bb/cascades/AbstractCover>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/ApplicationInfo>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
                        QObject()
{

    // get app version without hardcoding
    bb::ApplicationInfo appInfo;
    QDeclarativePropertyMap* appProperties = new QDeclarativePropertyMap;
    appProperties->insert("name", QVariant(appInfo.title()));
    appProperties->insert("version", QVariant(appInfo.version()));
    appProperties->insert("description", QVariant(appInfo.description()));

    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler,
            SIGNAL(systemLanguageChanged()),
            this,
            SLOT(onSystemLanguageChanged()));

    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app,
    // this is added to avoid a compiler warning.
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();
    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("AppInfo", appProperties);

    QmlDocument *qmlCover = QmlDocument::create("asset:///AppCover.qml").parent(this);

    if (!qmlCover->hasErrors()) {
        // Create the QML Container from using the QMLDocument.
        Container *coverContainer = qmlCover->createRootObject<Container>();

        // Create a SceneCover and set the application cover
        SceneCover *sceneCover = SceneCover::create().content(coverContainer);
        Application::instance()->setCover(sceneCover);
    }

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    new QmlBeam(this);

}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("bbdownloader_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()
        ->installTranslator(m_pTranslator);
    }
}
