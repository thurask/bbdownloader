/*UpdateChecker.cpp
-------------------
Handles app version lookup.

--Thurask*/

#include "UpdateChecker.hpp"
#include <bb/ApplicationInfo>

UpdateChecker::UpdateChecker()
{

}

void UpdateChecker::checkForUpdates()
{
    setLocalVersion(bb::ApplicationInfo().version());
    QUrl url("http://thurask.github.io/bbdownloader_version_1030.txt");
    QNetworkAccessManager *nam = new QNetworkAccessManager(this);
    QNetworkReply *reply = nam->get(QNetworkRequest(url));
    connect(reply, SIGNAL(finished()), this, SLOT(writeUpdateFile()));
}

void UpdateChecker::writeUpdateFile()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QString result = QString(reply->readAll());
    if (result == ""){
        setUpdateVersion(localVersion);
    }
    else {
        setUpdateVersion(result);
    }
    sender()->deleteLater();
}

QString UpdateChecker::getUpdateVersion()
{
    return updateVersion;
}

void UpdateChecker::setUpdateVersion(QString text)
{
    updateVersion = text.simplified().toUtf8();
    compareUpdate();
}

QString UpdateChecker::getLocalVersion()
{
    return localVersion;
}

void UpdateChecker::setLocalVersion(QString text)
{
    localVersion = text.toUtf8();
}

void UpdateChecker::setUpdateAvailable(bool truth)
{
    updateAvailable = truth;
}

bool UpdateChecker::getUpdateAvailable()
{
    return updateAvailable;
}

void UpdateChecker::compareUpdate()
{
    int x = QString::compare(updateVersion, localVersion, Qt::CaseInsensitive);  // if strings are equal x should return 0
    if (x == 0){
        updateAvailable = false;
    }
    if (x != 0) {
        updateAvailable = true;
    }
    emit updateAvailableChanged();
}

UpdateChecker::~UpdateChecker()
{

}

