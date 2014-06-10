/*
 * SwLookup.hpp
 *
 *  Created on: Jun 10, 2014
 *      Author: thura_000
 */

#ifndef SWLOOKUP_HPP_
#define SWLOOKUP_HPP_

#include <QtCore>
#include <QtNetwork>

class QNetworkAccessManager;

class SwLookup : public QObject
{
    Q_OBJECT
public:
    SwLookup(QObject* parent = 0);

public Q_SLOTS:
void post(QString osVer);
    QString softwareRelease();

Q_SIGNALS:
    void softwareReleaseChanged();

private Q_SLOTS:
    void onGetReply();

private:
    QNetworkAccessManager* m_networkAccessManager;
    QString m_softwareRelease;
};



#endif /* SWLOOKUP_HPP_ */
