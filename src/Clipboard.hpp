/*
 * Clipboard.hpp
 *
 *  Created on: Jul 3, 2014
 *      Author: thura_000
 */

#ifndef CLIPBOARD_HPP_
#define CLIPBOARD_HPP_

#include <bb/system/Clipboard>
#include <QtCore>

class Clipboard: public QObject {
        Q_OBJECT

public:
        Clipboard();

        Q_INVOKABLE
        void copyToClipboard(const QByteArray copyText);
};

#endif /* CLIPBOARD_HPP_ */
