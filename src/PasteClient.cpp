#include "PasteClient.hpp"

#include <QtCore>
#include <QtNetwork>

PasteClient::PasteClient()
{

}

void PasteClient::uploadPaste(QString payload)
{
    apikey = "b7c91d3c4f31ab6b8241a03356cce646"; //if you're recompiling this, get your own :P
    QUrl url("https://paste.ee/api");
    url.addEncodedQueryItem("key", QUrl::toPercentEncoding(apikey));
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

void PasteClient::setUploadUrl(QString paste)
{
    uploadUrl = paste;
    emit uploadUrlChanged();
}

QString PasteClient::getUploadUrl()
{
    return uploadUrl;
}

void PasteClient::setApiKey(QString key)
{
    apikey = key;
    emit apiKeyChanged();
}

QString PasteClient::getApiKey()
{
    return apikey;
}

PasteClient::~PasteClient()
{

}

