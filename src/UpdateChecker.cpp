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
    QUrl url("http://thurask.github.io/version.txt");
    QNetworkAccessManager *nam = new QNetworkAccessManager(this);
    QNetworkReply *reply = nam->get(QNetworkRequest(url));
    connect(reply, SIGNAL(finished()), this, SLOT(writeUpdateFile()));
}

void UpdateChecker::writeUpdateFile()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    setUpdateVersion(QString(reply->readAll()));
    sender()->deleteLater();
}

QString UpdateChecker::getUpdateVersion()
{
    emit updateVersionChanged();
    return updateVersion;
}

void UpdateChecker::setUpdateVersion(QString text)
{
    updateVersion = text.simplified().toUtf8();
}

QString UpdateChecker::getLocalVersion()
{
    emit localVersionChanged();
    return localVersion;
}

void UpdateChecker::setLocalVersion(QString text)
{
    localVersion = text.toUtf8();
}

bool UpdateChecker::returnUpdate()
{
    int x = QString::compare(updateVersion, localVersion, Qt::CaseInsensitive);  // if strings are equal x should return 0
    if (x == 0){
        return false;
    }
    else{
        return true;
    }
}

UpdateChecker::~UpdateChecker()
{

}

