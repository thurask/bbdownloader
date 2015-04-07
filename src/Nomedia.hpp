#ifndef NOMEDIA_HPP_
#define NOMEDIA_HPP_

#include <QtCore>
#include "FlurryAnalytics.hpp"

/*!
 *  @class     Nomedia
 *  @brief     Nomedia class
 *  @details   Handle creation/deletion of .nomedia files
 *  @author    Thurask
 *  @date      2014-2015
 */
class Nomedia: public QObject
{
    Q_OBJECT

public:
    Nomedia();
    virtual ~Nomedia();

    FlurryAnalytics fa;

public Q_SLOTS:
    Q_INVOKABLE
    void setDir(const QString& directory);Q_INVOKABLE
    bool checkNomedia();Q_INVOKABLE
    void deleteNomedia();Q_INVOKABLE
    void writeNomedia();

private:
    QDir dir;
    QFile file;
};

#endif /* NOMEDIA_HPP_ */
