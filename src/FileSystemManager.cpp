#include "FileSystemManager.hpp"

FileSystemManager::FileSystemManager()
{

}

void FileSystemManager::setDefaultDir(const QString& dir)
{
    default_dir = dir;
}

QString FileSystemManager::defaultDir()
{
    return default_dir;
}

void FileSystemManager::saveTextFile(const QString& content, const QString& title)
{
    QDir dir(default_dir);
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    //Get local date and time
    QDateTime dateTime = QDateTime::currentDateTime();
    QString dateTimeString = dateTime.toString("yyyy_MMM_dd_hh_mm_ss");
    QFile file(default_dir + title + "-" + dateTimeString + ".txt");
    QFileInfo fi(file);
    filename = fi.absoluteFilePath();
    file.open(QIODevice::WriteOnly);
    QTextStream outStream(&file);
    outStream << content;
    file.close();
    fa.logEvent("TEXTFILE_SAVED", false);
}

QString FileSystemManager::returnFilename()
{
    return "file://" + filename;
}

QString FileSystemManager::readTextFile(const QString& uri, const QString& mode)
{
    QFile file(uri);
    file.open(QIODevice::ReadOnly);
    QTextStream textStream(&file);
    QString text;
    QStringList switchcases;
    switchcases << "normal" << "firstline" << "branch" << "normsimp" << "firstsimp"; //mmm, dat elegance
    switch (switchcases.indexOf(mode)) {
        case 0:
            text = textStream.readAll();
            break;
        case 1:
            text = textStream.readLine();
            break;
        case 2:
            while (!textStream.atEnd()) {
                QString tempstring = textStream.readLine();
                if (tempstring.startsWith("Build Branch") == true) {
                    text = tempstring;
                }
            }
            break;
        case 3:
            text = textStream.readAll();
            text = text.simplified();
            break;
        case 4:
            text = textStream.readLine();
            text = text.simplified();
            break;
        default:
            text = textStream.readAll();
            break;
    }
    file.close();
    if (text.startsWith('\n')) {
        text.remove(0, 1);
    }
    if (text.endsWith('\n')) {
        text.chop(1);
    }
    return text;
}

QString FileSystemManager::getcwd()
{
    return QDir::currentPath();
}
