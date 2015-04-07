#ifndef FLURRYANALYTICS_HPP_
#define FLURRYANALYTICS_HPP_

#include <QtCore>
#include <Flurry.h>

/*!
 *  @class     FlurryAnalytics
 *  @brief     FlurryAnalytics class
 *  @details   Interface between Flurry and QML
 *  @author    Thurask
 *  @date      2015
 */
class FlurryAnalytics: public QObject
{
    Q_OBJECT

public:
    FlurryAnalytics();
    Q_INVOKABLE
    void logEvent(const QString& eventName, bool timedEvent=false);
    Q_INVOKABLE
    void endTimedEvent(const QString& eventName);
    Q_INVOKABLE
    void logError(const QString& error, const QString& message, const QString& exception);
};

#endif /* FLURRYANALYTICS_HPP_ */
