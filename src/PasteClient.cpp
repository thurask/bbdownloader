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
    //PASTEBIN
    //apikey = "a9407bebdebafc0624c1bbc24c38b03e";
    /*QUrl url("http://pastebin.com/api/api_post.php");
    url.addEncodedQueryItem("api_dev_key", QUrl::toPercentEncoding(apikey));
    url.addEncodedQueryItem("api_option", QUrl::toPercentEncoding("paste"));
    url.addEncodedQueryItem("api_paste_code", QUrl::toPercentEncoding(payload));
    url.addEncodedQueryItem("api_paste_name", QUrl::toPercentEncoding("BBDownloader Paste"));*/
    //PASTEEE
    apikey = "b7c91d3c4f31ab6b8241a03356cce646";
    //PASTEE ALTERNATE
    //apikey = "9de544e192ad027add473014b21ba3ec";
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
    qDebug() << url.toString();
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

