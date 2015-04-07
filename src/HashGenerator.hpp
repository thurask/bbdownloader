#ifndef HASHGENERATOR_HPP_
#define HASHGENERATOR_HPP_

#include <QtCore>
#include "FlurryAnalytics.hpp"

/*!
 *  @class     HashGenerator
 *  @brief     HashGenerator class
 *  @details   Perform cryptographic hashing of input
 *  @author    Thurask
 *  @date      2015
 */
class HashGenerator: public QObject
{
    Q_OBJECT
    Q_ENUMS(Hashmode Filemode)

public:
    HashGenerator();

    enum Hashmode
    {
        MD4 = 0, MD5, SHA1
    };

    enum Filemode
    {
        TEXT = 0, FILE
    };

    FlurryAnalytics fa;

    public Q_SLOTS:

    Q_INVOKABLE
    void calculateHash(QString input, Hashmode hashmode, Filemode filemode);

    Q_INVOKABLE
    QString returnHash();

    Q_INVOKABLE
    void calculateEscreen(QString pin, QString version, QString uptime, QString validity);

    Q_INVOKABLE
    QString returnEscreen();

    private Q_SLOTS:
    void filemodeSwitcher(QString input, Filemode filemode, QCryptographicHash& qch);

    private:
    QString hash;
    QString escreen;
};

#endif /* HASHGENERATOR_HPP_ */
