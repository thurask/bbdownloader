/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Page>
#include <bb/cascades/Window>

#include <QtCore>

#include "hashcalculatesha.hpp"
#include "DownloadManager.hpp"
#include "Settings.hpp"
#include "QmlBeam.hpp"

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
    app.mainWindow()->setScreenIdleMode(ScreenIdleMode::KeepAwake);

    #ifndef QT_NO_DEBUG
    qInstallMsgHandler(myMessageOutput);
    #endif

    HashCalculateSha *ihashcalcsha =  new HashCalculateSha();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("hashCalculateSha", ihashcalcsha);

    DownloadManager manager;
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_manager", &manager);

    Settings *settings = new Settings();
    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("Settings", settings);

    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    ApplicationUI appui;

    // Enter the application main event loop.
    return Application::exec();
}
