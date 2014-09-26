/*
 * Nomedia.hpp
 *
 *  Created on: Sep 25, 2014
 *      Author: Thurask
 */

#ifndef NOMEDIA_HPP_
#define NOMEDIA_HPP_

#include <QtCore> //for Qt to work

class Nomedia: public QObject //add public QObject for getting this to work with QML
{
    Q_OBJECT //this too

public:
    Nomedia();
    virtual ~Nomedia();

    public Q_SLOTS:
    Q_INVOKABLE //Q_INVOKABLE means we can directly use this function from QML; see main.cpp
    void setDir(QString directory); //set dir variable
    Q_INVOKABLE
    bool checkNomedia(); //check if file exists in dir
    Q_INVOKABLE
    void deleteNomedia(); //delete file
    Q_INVOKABLE
    void writeNomedia(); //create file

    private: //stuff that we don't need exposed to QML
    QDir dir;
    QFile file;
};

#endif /* NOMEDIA_HPP_ */
