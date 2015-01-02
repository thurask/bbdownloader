#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

    #include <QtCore>

    class DownloadManager : public QObject
    {
        Q_OBJECT

    public:
        DownloadManager();

    public Q_SLOTS:

        QString returnOsLinks(QString hashedswversion, QString osversion, bool verizon);

        QString returnRadioLinks(QString hashedswversion, QString osversion, QString radioversion);

        void setOsLinks(QString hashedswversion, QString osversion, bool verizon);

        void setRadioLinks(QString hashedswversion, QString osversion, QString radioversion);

        void saveTextFile(QString urls, QString swrelease);

        void exportLinks(QString swrelease, QString hashedswversion, QString osversion, QString radioversion, bool verizon);

        void copyLinks(QString hashedswversion, QString osversion, QString radioversion, bool verizon);

        QString returnLinks(QString hashedswversion, QString osversion, QString radioversion, bool verizon);

        QString returnFilename();

        QString readTextFile(QString uri, QString mode);

        void setDefaultDir(QString dir);

        QString defaultDir();

    private:

        void setExportUrls(QString hashedswversion, QString osversion, QString radioversion, bool verizon);

        QString exporturls;

        QString radiolinks;

        QString oslinks;

        QString filename;

        QString default_dir;
    };

#endif /* DOWNLOADMANAGER_HPP_ */
