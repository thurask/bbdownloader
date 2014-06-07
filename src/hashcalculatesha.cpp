/*
 * hashcalculatesha.cpp
 *
 *  Created on: Jun 6, 2014
 *      Author: thura_000
 */


#include "hashcalculatesha.h"
#include <QCryptographicHash>
#include "QDebug"
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
