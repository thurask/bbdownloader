/*
 * UpdateChecker.hpp
 *
 *  Created on: Sep 22, 2014
 *      Author: Thurask
 */

#ifndef UPDATECHECKER_HPP_
#define UPDATECHECKER_HPP_

#include <bb/ApplicationInfo>
#include <QtCore>
#include <QtNetwork>

class UpdateChecker: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString updateVersion READ getUpdateVersion WRITE setUpdateVersion NOTIFY updateVersionChanged)
    Q_PROPERTY(QString localVersion READ getLocalVersion WRITE setLocalVersion NOTIFY localVersionChanged)

public:
    UpdateChecker();

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
    bool returnUpdate();

Q_SIGNALS:
    void updateVersionChanged();
    void localVersionChanged();

private:
    QString updateVersion;
    QString localVersion;

private Q_SLOTS:
    void writeUpdateFile();
};

#endif /* UPDATECHECKER_HPP_ */
