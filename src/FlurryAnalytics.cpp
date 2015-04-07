#include "FlurryAnalytics.hpp"
#include <Flurry.h>

FlurryAnalytics::FlurryAnalytics()
{

}

void FlurryAnalytics::logEvent(const QString& eventName, bool timedEvent)
{
    Flurry::Analytics::LogEvent(eventName, timedEvent);
}

void FlurryAnalytics::endTimedEvent(const QString& eventName)
{
    Flurry::Analytics::EndTimedEvent(eventName);
}

void FlurryAnalytics::logError(const QString& error, const QString& message, const QString& exception)
{
    Flurry::Analytics::LogError(error, message, exception);
}
