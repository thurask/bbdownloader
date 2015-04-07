#ifndef CLIPBOARD_HPP_
#define CLIPBOARD_HPP_

#include <bb/system/Clipboard>
#include <QtCore>

/*!
 *  @class     Clipboard
 *  @brief     Clipboard class
 *  @details   Copies input QByteArray to system clipboard
 *  @author    Thurask
 *  @date      2014-2015
 */
class Clipboard: public QObject
{
    Q_OBJECT

public:
    Clipboard();

    Q_INVOKABLE
    void copyToClipboard(const QByteArray& copyText);
};

#endif /* CLIPBOARD_HPP_ */
