/*hashcalculatemd5.cpp
----------------------
MD5 hashes a given input.

--Thurask*/

#include "hashcalculatemd5.hpp"
#include <QCryptographicHash>
#include <QFile>

HashCalculateMd5::HashCalculateMd5(QObject *parent) :
QObject(parent)
{
    iHashValue = "";
}

void HashCalculateMd5::calculateHash(const QString& aOriginalText )
{
    QCryptographicHash hash(QCryptographicHash::Md5);
    hash.addData(aOriginalText.toUtf8());
    SetHash(QString(hash.result().toHex()));
}

void HashCalculateMd5::calculateFileHash(QString fileName)
{
 QCryptographicHash filehash(QCryptographicHash::Md5);
 QFile file(fileName);
 file.open(QFile::ReadOnly);
 while(!file.atEnd()){
     filehash.addData(file.read(8192));
 }
 QByteArray filehasharray = filehash.result();
 SetHash(QString(filehasharray.toHex()));
}

void HashCalculateMd5::SetHash(const QString& aHashValue)
{
    iHashValue = aHashValue;
}

QString HashCalculateMd5::getHash()
{
    return iHashValue;
}
