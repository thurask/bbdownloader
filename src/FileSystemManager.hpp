#ifndef FILESYSTEMMANAGER_HPP_
#define FILESYSTEMMANAGER_HPP_

#include <QtCore>
#include "Settings.hpp"
#include "Clipboard.hpp"

/*!
 *  @class     FileSystemManager
 *  @brief     FileSystemManager class
 *  @details   Handles filesystem work
 *  @author    Thurask
 *  @date      2015
 */
class FileSystemManager: public QObject
{
    Q_OBJECT

public:
    FileSystemManager();

    Settings settings;

    Clipboard clipboard;

public Q_SLOTS:

    void saveTextFile(const QString& content, const QString& title);

    QString returnFilename();

    QString readTextFile(const QString& uri, const QString& mode);

    void setDefaultDir(const QString& dir);

    QString defaultDir();

    QString getcwd();

private:

    QString filename;

    QString default_dir;
};

#endif /* FILESYSTEMMANAGER_HPP_ */
