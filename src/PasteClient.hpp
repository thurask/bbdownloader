#ifndef PASTECLIENT_HPP_
#define PASTECLIENT_HPP_

#include <QtCore>
#include <QtNetwork>

/*!
 *  @class     PasteClient
 *  @brief     PasteClient class
 *  @details   Handles text upload to paste.ee + handling of results
 *  @author    Thurask
 *  @date      2015
 */
class PasteClient: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString uploadUrl WRITE setUploadUrl READ getUploadUrl NOTIFY uploadUrlChanged)

    Q_PROPERTY(QString apikey WRITE setApiKey READ getApiKey NOTIFY apiKeyChanged)

public:
    PasteClient();
    virtual ~PasteClient();

public Q_SLOTS:
    Q_INVOKABLE
    void uploadPaste(QString payload);

    void setUploadUrl(QString paste);

    Q_INVOKABLE
    QString getUploadUrl();

    void setApiKey(QString key);

    QString getApiKey();

    Q_SIGNALS:
    void uploadUrlChanged();
    void apiKeyChanged();

private Q_SLOTS:
    void pasteReply();

private:
    QString apikey;
    QString uploadUrl;
};

#endif /* PASTECLIENT_HPP_ */
