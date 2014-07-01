/*QmlBeam.cpp
--------------
Supposedly allows for live QML editing on-device. Rarely works.

--Thurask*/

#include "QmlBeam.hpp"

#include <QDeclarativeContext>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/core/developmentsupport.h>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

QmlBeam::QmlBeam(QObject *parent) : QObject(parent)
{
    bool connectResult;
    Q_UNUSED(connectResult);

    // Get the application scene. It's needed since
    // the scene is recreated when QML files are changed.
    mRoot = Application::instance()->scene();
    Q_ASSERT(mRoot);

    mRoot->setParent(this);

    // Create the Development support object and connect to
    // its signal, so that the application scene can be recreated
    // when changes are made to the QML files.
    DevelopmentSupport* devSupport = new DevelopmentSupport(this);
    connectResult = connect(devSupport,
                            SIGNAL(assetsChanged(QUrl)),
                            SLOT(reloadQML(QUrl)));
    Q_ASSERT(connectResult);


    connectResult = connect(Application::instance(),
                            SIGNAL(aboutToQuit()),
                            SLOT(cleanup()));

    Q_ASSERT(connectResult);
}

void QmlBeam::reloadQML(QUrl mainFile) {
    // Get the context of the first scene root
    // to keep the contextProperties
    QDeclarativeContext* context =
        QDeclarativeEngine::contextForObject(mRoot);

    // Clear the QML cache
    QDeclarativeEngine* appEngine = context->engine();
    Q_ASSERT(appEngine);
    appEngine->clearComponentCache();

    // Reload all QML
    QmlDocument* qml = QmlDocument::create(mainFile);
    AbstractPane *root =
            qml->createRootObject<AbstractPane>(context);
    qml->setParent(root);
    Application::instance()->setScene(root);
}

void QmlBeam::cleanup() {
    // Clean up.
    Application::instance()->setScene(0);
    mRoot->setParent(0);
    delete mRoot;
}


