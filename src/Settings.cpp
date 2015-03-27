/*Settings.cpp
 --------------
 Handles app theme settings.

 --Thurask*/

#include "Settings.hpp"

#include <QtCore>

Settings::Settings()
{
}

QString Settings::getValueFor(const QString &objectName, const QString &defaultValue)
{
    QSettings settings;
    if (settings.value(objectName).isNull()) {
        return defaultValue;
    }
    return settings.value(objectName).toString();
}

void Settings::clearSettings()
{
    QSettings settings;
    settings.clear();
}

void Settings::saveValueFor(const QString &objectName, const QString &inputValue)
{
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
}
