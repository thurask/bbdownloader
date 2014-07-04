#ifndef HASHCALCULATEMD4_HPP_
#define HASHCALCULATEMD4_HPP_

#include <QObject>

class HashCalculateMd4 : public QObject
{
    Q_OBJECT
public:
    explicit HashCalculateMd4(QObject *parent = 0);
    Q_INVOKABLE void calculateHash(const QString& aOriginalText );
    Q_INVOKABLE void calculateFileHash(QString fileName);

signals:

public slots:
       QString getHash();
       void SetHash(const QString& aHashValue);
public:
       QString iHashValue;
};

#endif /* HASHCALCULATEMD4_HPP_ */
