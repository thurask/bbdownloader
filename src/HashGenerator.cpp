#include "HashGenerator.hpp"
#include <QtCore>

HashGenerator::HashGenerator()
{
    hash = "";
}

void HashGenerator::calculateHash(QString input, Hashmode hashmode, Filemode filemode)
{
    switch (hashmode) {
        case MD4: {
            QCryptographicHash qch(QCryptographicHash::Md4);
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
                }
                default: {
                    break;
                }
            }
            break;
        }
        case MD5: {
            QCryptographicHash qch(QCryptographicHash::Md5);
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
                }
                default: {
                    break;
                }
            }
            break;
        }
        case SHA1: {
            QCryptographicHash qch(QCryptographicHash::Sha1);
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
                }
                default: {
                    break;
                }
            }
            break;
        }
        default: {
            break;
        }
    }
}

QString HashGenerator::returnHash()
{
    return hash;
}
