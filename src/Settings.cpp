/*
 * Settings.cpp
 *
 *  Created on: Jun 10, 2014
 *      Author: thura_000
 */

#include "Settings.hpp"

#include <QtCore>

Settings::Settings() {
}

QString Settings::getValueFor(const QString &objectName, const QString &defaultValue) {
        QSettings settings;

        // If no value has been saved, return the default value.
        if (settings.value(objectName).isNull()) {
                return defaultValue;
        }

        // Otherwise, return the value stored in the settings object.
        return settings.value(objectName).toString();
}

void Settings::saveValueFor(const QString &objectName, const QString &inputValue) {
        // A new value is saved to the application settings object.
        QSettings settings;
        settings.setValue(objectName, QVariant(inputValue));
}

Settings::~Settings() {
}


