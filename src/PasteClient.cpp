#include "PasteClient.hpp"

#include <QtCore>
#include <QtNetwork>

PasteClient::PasteClient()
{

}

void PasteClient::uploadPaste(QString payload)
{
    QUrl url("https://paste.ee/api");
    url.addEncodedQueryItem("key", QUrl::toPercentEncoding(PASTEEE_API_KEY));
    url.addEncodedQueryItem("format", QUrl::toPercentEncoding("simple")); //it isn't source code, so don't tell the server to format it like source code
    url.addEncodedQueryItem("paste", QUrl::toPercentEncoding(payload));
    url.addEncodedQueryItem("description", QUrl::toPercentEncoding("BBDownloader Paste")); //better than "Untitled Paste"
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    QNetworkAccessManager *http = new QNetworkAccessManager(this);
    QNetworkReply* reply = http->post(request, url.encodedQuery());
    connect(reply, SIGNAL(finished()), this, SLOT(pasteReply()));
}

void PasteClient::pasteReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    QVariant url = reply->readAll();
    setUploadUrl(url.toString());
    sender()->deleteLater();
}

void PasteClient::setUploadUrl(const QString& paste)
{
    uploadUrl = paste;
    emit uploadUrlChanged();
}

QString PasteClient::getUploadUrl()
{
    return uploadUrl;
}

PasteClient::~PasteClient()
{

}

