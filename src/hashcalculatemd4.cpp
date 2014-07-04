/*hashcalculatemd4.cpp
----------------------
MD4 hashes a given input.

--Thurask*/

#include "hashcalculatemd4.hpp"
#include <QCryptographicHash>
#include <QFile>

HashCalculateMd4::HashCalculateMd4(QObject *parent) :
QObject(parent)
{
    iHashValue = "";
}

void HashCalculateMd4::calculateHash(const QString& aOriginalText )
{
    QCryptographicHash hash(QCryptographicHash::Md4);
    hash.addData(aOriginalText.toUtf8());
    SetHash(QString(hash.result().toHex()));
}

void HashCalculateMd4::calculateFileHash(QString fileName)
{
 QCryptographicHash filehash(QCryptographicHash::Md4);
 QFile file(fileName);
 file.open(QFile::ReadOnly);
 while(!file.atEnd()){
     filehash.addData(file.read(8192));
 }
 QByteArray filehasharray = filehash.result();
 SetHash(QString(filehasharray.toHex()));
}

void HashCalculateMd4::SetHash(const QString& aHashValue)
{
    iHashValue = aHashValue;
}

QString HashCalculateMd4::getHash()
{
    return iHashValue;
}
