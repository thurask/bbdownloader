/*
 * Nomedia.hpp
 *
 *  Created on: Sep 25, 2014
 *      Author: Thurask
 */

#ifndef NOMEDIA_HPP_
#define NOMEDIA_HPP_

#include <QtCore>

class Nomedia: public QObject
{
    Q_OBJECT

public:
    Nomedia();
    virtual ~Nomedia();

    public Q_SLOTS:
    Q_INVOKABLE
    void setDir(QString directory);
    Q_INVOKABLE
    bool checkNomedia();
    Q_INVOKABLE
    void deleteNomedia();
    Q_INVOKABLE
    void writeNomedia();

    private:
    QDir dir;
    QFile file;
};

#endif /* NOMEDIA_HPP_ */