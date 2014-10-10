/*
 * UpdateChecker.hpp
 *
 *  Created on: Sep 22, 2014
 *      Author: Thurask
 */

#ifndef UPDATECHECKER_HPP_
#define UPDATECHECKER_HPP_

#include <QtCore>
#include <QtNetwork>

class UpdateChecker: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString updateVersion READ getUpdateVersion WRITE setUpdateVersion)
    Q_PROPERTY(QString localVersion READ getLocalVersion WRITE setLocalVersion)
    Q_PROPERTY(bool updateAvailable READ getUpdateAvailable WRITE setUpdateAvailable NOTIFY updateAvailableChanged)

public:
    UpdateChecker();
    virtual ~UpdateChecker();

public Q_SLOTS:
    Q_INVOKABLE
    void checkForUpdates();
    Q_INVOKABLE
    void setUpdateVersion(QString text);
    Q_INVOKABLE
    QString getUpdateVersion();
    Q_INVOKABLE
    void setLocalVersion(QString text);
    Q_INVOKABLE
    QString getLocalVersion();
    Q_INVOKABLE
    void setUpdateAvailable(bool truth);
    Q_INVOKABLE
    bool getUpdateAvailable();

signals:
    void updateAvailableChanged();

private:
    QString updateVersion;
    QString localVersion;
    bool updateAvailable;

private Q_SLOTS:
    void writeUpdateFile();
    void compareUpdate();
};

#endif /* UPDATECHECKER_HPP_ */
