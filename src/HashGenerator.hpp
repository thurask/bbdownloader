#ifndef HASHGENERATOR_HPP_
#define HASHGENERATOR_HPP_

#include <QtCore>

/*
 *
 */
class HashGenerator : public QObject
{
    Q_OBJECT
    Q_ENUMS(Hashmode Filemode)

public:
    HashGenerator();

    enum Hashmode {
        MD4 = 0,
        MD5,
        SHA1
    };

    enum Filemode {
        TEXT = 0,
        FILE
    };

    public Q_SLOTS:

    Q_INVOKABLE
    void calculateHash(QString input, Hashmode hashmode, Filemode filemode);

    Q_INVOKABLE
    QString returnHash();

    private:

    QString hash;
};

#endif /* HASHGENERATOR_HPP_ */
