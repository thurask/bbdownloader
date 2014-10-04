/*
 * LinkGenerator.hpp
 *
 *  Created on: Sep 23, 2014
 *      Author: Thurask
 */

#ifndef LINKGENERATOR_HPP_
#define LINKGENERATOR_HPP_

#include <QtCore>

class LinkGenerator: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString osLink READ getOS WRITE forceOS)

    Q_PROPERTY(QString radioLink READ getRadio WRITE forceRadio)

    Q_PROPERTY(QString deltaOsLink READ getDeltaOS WRITE forceDeltaOS)

    Q_PROPERTY(QString deltaRadioLink READ getDeltaRadio WRITE forceDeltaRadio)

    Q_PROPERTY(QString osLabel READ getOsLabel)

    Q_PROPERTY(QString radioLabel READ getRadioLabel)

    Q_PROPERTY(QString deltaOsLabel READ getDeltaOsLabel)

    Q_PROPERTY(QString deltaRadioLabel READ getDeltaRadioLabel)

public:
    LinkGenerator();
    virtual ~LinkGenerator();

    public Q_SLOTS:
    Q_INVOKABLE
    QString incrementRadio(QString input);
    Q_INVOKABLE
    void setAutoloader(QString os, QString device, bool useOldAutoloader);
    Q_INVOKABLE
    void setOS(QString os, QString swrelease, QString type, QString device);
    Q_INVOKABLE
    void setRadio(QString radio, QString swrelease, QString device);
    Q_INVOKABLE
    void setDeltaOS(QString os, QString initialos, QString swrelease, QString type, QString device);
    Q_INVOKABLE
    void setDeltaRadio(QString radio, QString initialradio, QString swrelease, QString device);
    Q_INVOKABLE
    void setOsLabel(QString type);
    Q_INVOKABLE
    void setRadioLabel(QString device);
    Q_INVOKABLE
    void setDeltaOsLabel(QString type, QString os, QString initialos);
    Q_INVOKABLE
    void setDeltaRadioLabel(QString device, QString radio, QString initialradio);

    Q_INVOKABLE
    void forceOS(QString text);
    Q_INVOKABLE
    void forceRadio(QString text);
    Q_INVOKABLE
    void forceDeltaOS(QString text);
    Q_INVOKABLE
    void forceDeltaRadio(QString text);

    Q_INVOKABLE
    QString getOS();
    Q_INVOKABLE
    QString getRadio();
    Q_INVOKABLE
    QString getDeltaOS();
    Q_INVOKABLE
    QString getDeltaRadio();
    Q_INVOKABLE
    QString getOsLabel();
    Q_INVOKABLE
    QString getRadioLabel();
    Q_INVOKABLE
    QString getDeltaOsLabel();
    Q_INVOKABLE
    QString getDeltaRadioLabel();

    private:

    QString osLink;
    QString radioLink;
    QString deltaOsLink;
    QString deltaRadioLink;
    QString osLabel;
    QString radioLabel;
    QString deltaOsLabel;
    QString deltaRadioLabel;
};

#endif /* LINKGENERATOR_HPP_ */
