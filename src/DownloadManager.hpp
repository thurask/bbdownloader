#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

    #include <QtCore>

    class DownloadManager : public QObject
    {
        Q_OBJECT

    public:
        DownloadManager();

    public Q_SLOTS:

        void saveTextFile(QString urls, QString swrelease);

        void exportLinks(QString swrelease, QString hashedswversion, QString osversion, QString radioversion);

        void copyLinks(QString hashedswversion, QString osversion, QString radioversion);

        QString returnLinks(QString hashedswversion, QString osversion, QString radioversion);

        QString returnFilename();

        QString readTextFile(QString uri, QString mode);

        void setDefaultDir(QString dir);

        QString defaultDir();

    private:

        void setExportUrls(QString hashedswversion, QString osversion, QString radioversion);

        QString exporturls;

        QString filename;

        QString default_dir;
    };

#endif /* DOWNLOADMANAGER_HPP_ */
