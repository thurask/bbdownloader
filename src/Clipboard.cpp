#include "Clipboard.hpp"
#include <bb/system/Clipboard>
#include <QtCore>

Clipboard::Clipboard()
{
}

void Clipboard::copyToClipboard(QByteArray copyText)
{
    bb::system::Clipboard clipboard; // create clipboard
    clipboard.clear(); //empty
    clipboard.insert("text/plain", copyText); //append
}
