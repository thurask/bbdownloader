/*
 * Clipboard.cpp
 *
 *  Created on: Jul 3, 2014
 *      Author: thura_000
 */

#include "Clipboard.hpp"
#include <bb/system/Clipboard>

Clipboard::Clipboard()
{
}

void Clipboard::copyToClipboard(QByteArray copyText){
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", copyText);
}

Clipboard::~Clipboard() {
}
