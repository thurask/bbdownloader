#ifndef PASTECLIENT_HPP_
#define PASTECLIENT_HPP_

#include <QtCore>
#include <QtNetwork>

const QString PASTEEE_API_KEY("b7c91d3c4f31ab6b8241a03356cce646");

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

public:
    PasteClient();
    virtual ~PasteClient();

public Q_SLOTS:
    Q_INVOKABLE
    void uploadPaste(QString payload);

    void setUploadUrl(const QString& paste);

    Q_INVOKABLE
    QString getUploadUrl();

    Q_SIGNALS:
    void uploadUrlChanged();

private Q_SLOTS:
    void pasteReply();

private:
    QString uploadUrl;
};

#endif /* PASTECLIENT_HPP_ */
