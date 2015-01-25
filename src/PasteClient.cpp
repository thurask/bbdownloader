/*
 * PasteClient.cpp
 *
 *  Created on: Jan 19, 2015
 *      Author: Thurask
 */

#include <PasteClient.hpp>

#include <QtCore>
#include <QtNetwork>

PasteClient::PasteClient()
{

}

void PasteClient::uploadPaste(QString payload)
{
    apikey = "b7c91d3c4f31ab6b8241a03356cce646";
    QUrl url("https://paste.ee/api");
    url.addEncodedQueryItem("key", QUrl::toPercentEncoding(apikey));
    url.addEncodedQueryItem("format", QUrl::toPercentEncoding("simple"));
    url.addEncodedQueryItem("paste", QUrl::toPercentEncoding(payload));
    url.addEncodedQueryItem("description", QUrl::toPercentEncoding("BBDownloader Paste"));
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
    // TODO Auto-generated destructor stub
}

