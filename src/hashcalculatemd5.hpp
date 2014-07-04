#ifndef HASHCALCULATEMD5_HPP_
#define HASHCALCULATEMD5_HPP_

#include <QObject>

class HashCalculateMd5 : public QObject
{
    Q_OBJECT
public:
    explicit HashCalculateMd5(QObject *parent = 0);
    Q_INVOKABLE void calculateHash(const QString& aOriginalText );
    Q_INVOKABLE void calculateFileHash(QString fileName);

signals:

public slots:
       QString getHash();
       void SetHash(const QString& aHashValue);
public:
       QString iHashValue;
};

#endif /* HASHCALCULATEMD5_HPP_ */
