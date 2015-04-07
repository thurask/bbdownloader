#include "HashGenerator.hpp"
#include <QtCore>

HashGenerator::HashGenerator()
{
    hash = "";
    escreen = "";
}

void HashGenerator::calculateHash(QString input, Hashmode hashmode, Filemode filemode)
{
    //Enum to enum
    int method = static_cast<int>(hashmode);
    QCryptographicHash::Algorithm algo = static_cast<QCryptographicHash::Algorithm>(method);
    QCryptographicHash qch(algo);
    filemodeSwitcher(input, filemode, qch);
}

void HashGenerator::filemodeSwitcher(QString input, Filemode filemode, QCryptographicHash& qch)
{
    switch (filemode) {
        case TEXT: {
            qch.addData(input.toUtf8());
            hash = QString(qch.result().toHex());
            break;
        }
        case FILE: {
            QFile file(input);
            file.open(QFile::ReadOnly);
            while (!file.atEnd()) {
                qch.addData(file.read(8192));
            }
            hash = QString(qch.result().toHex());
            break;
        }
    }
}

QString HashGenerator::returnHash()
{
    return hash;
}

void HashGenerator::calculateEscreen(QString pin, QString version, QString uptime,
        QString validity)
{
    escreen = "";
    QByteArray key("Up the time stream without a TARDIS");
    QString data = pin + version + uptime + validity;
    QByteArray baseString = data.toLatin1();
    const int blockSize = 64; // HMAC-SHA-1 block size, defined in SHA-1 standard
    if (key.length() > blockSize)
        QCryptographicHash::hash(key, QCryptographicHash::Sha1);
    while (key.length() < blockSize)
        key.append('\0');
    QByteArray innerPadding(blockSize, char(0x36)); // initialize inner padding with char "6"
    QByteArray outerPadding(blockSize, char(0x5c)); // initialize outer padding with char "\"
    for (int i = 0; i < key.length(); i++) {
        innerPadding[i] = innerPadding[i] ^ key.at(i); // XOR operation between every byte in key and innerpadding, of key length
        outerPadding[i] = outerPadding[i] ^ key.at(i); // XOR operation between every byte in key and outerpadding, of key length
    }
    QByteArray total = outerPadding;
    QByteArray part = innerPadding;
    part.append(baseString);
    total.append(QCryptographicHash::hash(part, QCryptographicHash::Sha1));
    QByteArray hashed = QCryptographicHash::hash(total, QCryptographicHash::Sha1);
    escreen = QString(hashed.toHex());
    escreen = escreen.left(8).toUpper(); //first 8 characters, uppercase
}

QString HashGenerator::returnEscreen()
{
    return escreen;
}
