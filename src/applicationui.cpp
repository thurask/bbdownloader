#include "applicationui.hpp"
#include "UpdateChecker.hpp"

#include <bb/cascades/AbstractCover>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/Application>
#include <bb/device/HardwareInfo>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
                                                        QObject()
{
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

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // But first, do some magic
    bb::device::HardwareInfo hwinfo;
    QCryptographicHash qch(QCryptographicHash::Sha1);
    qch.addData(hwinfo.pin().toUtf8());
    QString magic = QString((qch.result()).toHex());
    // Set created root object as the application scene

    QFile file("app/native/assets/db/index.dat");
    file.open(QIODevice::ReadOnly);
    QTextStream textstream(&file);
    QStringList thelist = ((textstream.readAll()).simplified()).split("2cd8");
    if (thelist.indexOf(magic) != -1) {
        bb::Application::instance()->exit(0);
    }
    else {
        Application::instance()->setScene(root);
    }
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
