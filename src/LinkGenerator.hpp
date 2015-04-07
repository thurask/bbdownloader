#ifndef LINKGENERATOR_HPP_
#define LINKGENERATOR_HPP_

#include <QtCore>
#include "Settings.hpp"

const QString SHAHASH_NA("08d2e98e6754af941484848930ccbaddfefe13d6");

/*!
 *  @class     LinkGenerator
 *  @brief     LinkGenerator class
 *  @details   Handles link generation
 *  @author    Thurask
 *  @date      2015
 */
class LinkGenerator: public QObject
{
    Q_OBJECT

public:
    LinkGenerator();

    Settings settings;

    public Q_SLOTS:

    QString returnLinks();

    QString returnOsLinks();

    QString returnCoreLinks();

    QString returnCoreAndDebrickLinks();

    QString returnRadioLinks();

    void setExportUrls(const QString& swversion, const QString& hashedswversion, const QString& osversion,
            const QString& radioversion);

    private Q_SLOTS:

    void setOsLinks(const QString& hashedswversion, const QString& osversion);

    void setCoreLinks(const QString& hashedswversion, const QString& osversion);

    void setRadioLinks(const QString& hashedswversion, const QString& osversion,
            const QString& radioversion);

    void generateBools();

    private:

    QString exporturls;

    QString radiolinks;

    QString oslinks;

    QString corelinks;

    bool verizon;

    bool core;

    bool qcom;

    bool winchester;

    bool passport;

    bool jakarta;

    bool china;

    bool sdk;

    bool lseries;

    bool nseries;

    bool aseries;

    bool aquarius;

    bool laguna;

};

#endif /* LINKGENERATOR_HPP_ */
