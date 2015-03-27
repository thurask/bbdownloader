#ifndef SETTINGS_HPP_
#define SETTINGS_HPP_

#include <QtCore>

class Settings: public QObject {
    Q_OBJECT

public:
    Settings();

    Q_INVOKABLE
    QString getValueFor(const QString &objectName, const QString &defaultValue);

    Q_INVOKABLE
    void clearSettings();

    Q_INVOKABLE
    void saveValueFor(const QString &objectName, const QString &inputValue);
};

#endif /* SETTINGS_HPP_ */
