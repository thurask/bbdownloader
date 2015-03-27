#include <QtCore>
#include <QtNetwork>
#include <QtXml>
#include "SwLookup.hpp"

SwLookup::SwLookup(QObject* parent) :
        QObject(parent), m_networkAccessManager(new QNetworkAccessManager(this))
{
    m_softwareRelease = "";
    m_server = "";
    m_availability = "";
}

void SwLookup::post(QString osVer, QString server)
{
    QRegExp rx("(\\d{0,4}\\.)(\\d{0,4}\\.)(\\d{0,4}\\.)(\\d{0,4})");
    if (osVer.contains(rx) == true) {
        if (server.contains("cs.sl") == true) {
            setServer("production");
        } else {
            setServer("private");
        }
        QUrl url(server);
        QNetworkRequest request(url);
        QString query =
                "<srVersionLookupRequest version=\"2.0.0\" authEchoTS=\"1366644680359\">"
                        "<clientProperties><hardware>"
                        "<pin>0x2FFFFFB3</pin><bsn>1140011878</bsn><imei>004402242176786</imei><id>0x8D00240A</id><isBootROMSecure>true</isBootROMSecure>"
                        "</hardware>"
                        "<network>"
                        "<vendorId>0x0</vendorId><homeNPC>0x60</homeNPC><currentNPC>0x60</currentNPC><ecid>0x1</ecid>"
                        "</network>"
                        "<software><currentLocale>en_US</currentLocale><legalLocale>en_US</legalLocale>"
                        "<osVersion>" + osVer
                        + "</osVersion><omadmEnabled>false</omadmEnabled></software></clientProperties>"
                                "</srVersionLookupRequest>";
        request.setHeader(QNetworkRequest::ContentTypeHeader, "text/xml;charset=UTF-8");
        QNetworkReply* reply = m_networkAccessManager->post(request, query.toUtf8());
        connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    } else {
        setSoftwareRelease(tr("Error"));
    }
}

void SwLookup::onGetReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    QByteArray data = reply->readAll();
    QXmlStreamReader xml(data);
    while (!xml.atEnd() && !xml.hasError()) {
        if (xml.tokenType() == QXmlStreamReader::StartElement) {
            if (xml.name() == "softwareReleaseVersion") {
                setSoftwareRelease(xml.readElementText());
                QCryptographicHash qch(QCryptographicHash::Sha1);
                qch.addData((m_softwareRelease).toUtf8());
                if (m_server == "production") {
                    checkAvailability(QString((qch.result()).toHex()));
                }
            }
        }
        xml.readNext();
    }
    sender()->deleteLater();
}

void SwLookup::checkAvailability(QString swrelease)
{
    QString av_url = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease;
    QNetworkRequest qnr;
    qnr.setUrl(QUrl(av_url));
    QNetworkReply* qnr_reply = m_networkAccessManager->head(qnr);
    connect(qnr_reply, SIGNAL(finished()), this, SLOT(availabilityReply()));
}

void SwLookup::availabilityReply()
{
    QNetworkReply* av_reply = (QNetworkReply*) sender();
    if (m_server == "production") {
        int status = av_reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        if (status == 200 || (status > 300 && status <= 308)) {
            setAvailability(tr("Valid"));
        } else {
            setAvailability(tr("Invalid"));
        }
    } else {
        setAvailability(tr("Invalid"));
    }
    av_reply->deleteLater();
}

void SwLookup::setSoftwareRelease(QString sw)
{
    m_softwareRelease = sw.toUtf8().simplified();
    emit softwareReleaseChanged();
}

QString SwLookup::softwareRelease()
{
    return m_softwareRelease;
}

QString SwLookup::getServer()
{
    return m_server;
}

void SwLookup::setServer(QString server)
{
    m_server = server;
}

QString SwLookup::getAvailability()
{
    return m_availability;
}

void SwLookup::setAvailability(QString availability)
{
    m_availability = availability;
}

QString SwLookup::lookupIncrement(QString os, int inc)
{
    QRegExp rx("(\\d{1,4}\\.)(\\d{1,4}\\.)(\\d{1,4}\\.)(\\d{1,4})");
    if (os.contains(rx) == true) {
        QStringList splitarray = os.split(".");
        if (splitarray[3].toInt() < 9999) {
            splitarray[3] = QString::number((splitarray[3]).toInt() + inc);
            return splitarray.join(".");
        } else {
            splitarray[3] = QString::number(0);
            return splitarray.join(".");
        }
    } else {
        return tr("Error");
    }
}

QString SwLookup::spaceTrimmer(QString lookup)
{
    if (lookup.endsWith(" ") == true || lookup.endsWith("\n") == true) {
        lookup.chop(1);
    }
    return lookup;
}
