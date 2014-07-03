#ifndef HASHCALCULATESHA_HPP_
#define HASHCALCULATESHA_HPP_

#include <QObject>

class HashCalculateSha : public QObject
{
    Q_OBJECT
public:
    explicit HashCalculateSha(QObject *parent = 0);
    Q_INVOKABLE void calculateHash(const QString& aOriginalText );

signals:

public slots:
       QString getHash();
       void SetHash(const QString& aHashValue);
public:
       QString iHashValue;
};

#endif /* HASHCALCULATESHA_HPP_ */
