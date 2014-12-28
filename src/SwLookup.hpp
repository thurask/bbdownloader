#ifndef SWLOOKUP_HPP_
#define SWLOOKUP_HPP_

#include <QtCore>
#include <QtNetwork>
#include <QtXml>

class QNetworkAccessManager;

class SwLookup : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString m_softwareRelease READ softwareRelease WRITE setSoftwareRelease NOTIFY softwareReleaseChanged)

public:
    SwLookup(QObject* parent = 0);

    public Q_SLOTS:
    void post(QString osVer, QString server);
    QString softwareRelease();
    void setSoftwareRelease(QString sw);
    QString lookupIncrement(QString os);

    Q_SIGNALS:
    void softwareReleaseChanged();

    private Q_SLOTS:
    void onGetReply();

    private:
    QNetworkAccessManager* m_networkAccessManager;
    QString m_softwareRelease;
};



#endif /* SWLOOKUP_HPP_ */
