/*hashcalculatesha.cpp
--------------
SHA-1 hashes a given text input.

--Thurask*/

#include "hashcalculatesha.hpp"
#include <QCryptographicHash>

HashCalculateSha::HashCalculateSha(QObject *parent) :
QObject(parent)
{
    iHashValue = "";
}

void HashCalculateSha::calculateHash(const QString& aOriginalText )
{
    QCryptographicHash hash(QCryptographicHash::Sha1);
    hash.addData(aOriginalText.toUtf8());
    SetHash(QString(hash.result().toHex()));
}

void HashCalculateSha::SetHash(const QString& aHashValue)
{
    iHashValue = aHashValue;
}

QString HashCalculateSha::getHash()
{
    return iHashValue;
}
