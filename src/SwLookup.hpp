#ifndef SWLOOKUP_HPP_
#define SWLOOKUP_HPP_

#include <QtCore>
#include <QtNetwork>
#include <QtXml>

class QNetworkAccessManager;

/*!
 *  @class     SwLookup
 *  @brief     SwLookup class
 *  @details   Interact with BlackBerry APIs (software release lookup)
 *  @author    Thurask
 *  @date      2014-2015
 */
class SwLookup: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString m_softwareRelease READ softwareRelease WRITE setSoftwareRelease NOTIFY softwareReleaseChanged)

    Q_PROPERTY(QString m_server READ getServer WRITE setServer)

    Q_PROPERTY(QString m_availability READ getAvailability WRITE setAvailability)

public:
    SwLookup(QObject* parent = 0);

public Q_SLOTS:
    void post(QString osVer, QString server);
    QString softwareRelease();
    void setSoftwareRelease(const QString& sw);
    QString getServer();
    void setServer(const QString& server);
    QString getAvailability();
    void checkAvailability(const QString & swrelease);
    void setAvailability(QString availability);
    QString lookupIncrement(QString os, const int inc);
    QString spaceTrimmer(QString lookup);

    Q_SIGNALS:
    void softwareReleaseChanged();

private Q_SLOTS:
    void onGetReply();
    void availabilityReply();

private:
    QNetworkAccessManager* m_networkAccessManager;
    QString m_softwareRelease;
    QString m_server;
    QString m_availability;
};

#endif /* SWLOOKUP_HPP_ */
