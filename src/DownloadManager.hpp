#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

    #include <QtCore>

    class DownloadManager : public QObject
    {
        Q_OBJECT

    public:
        DownloadManager();

    public Q_SLOTS:

        QString returnOsLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester);

        QString returnRadioLinks(QString hashedswversion, QString osversion, QString radioversion, bool winchester);

        void setOsLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester);

        void setRadioLinks(QString hashedswversion, QString osversion, QString radioversion, bool winchester);

        void saveTextFile(QString urls, QString swrelease);

        void exportLinks(QString swrelease, QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester);

        void copyLinks(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester);

        void copyOsLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester);

        void copyRadioLinks(QString hashedswversion, QString osversion, QString radioversion, bool winchester);

        QString returnLinks(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester);

        QString returnFilename();

        QString readTextFile(QString uri, QString mode);

        void setDefaultDir(QString dir);

        QString defaultDir();

    private:

        void setExportUrls(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester);

        QString exporturls;

        QString radiolinks;

        QString oslinks;

        QString filename;

        QString default_dir;
    };

#endif /* DOWNLOADMANAGER_HPP_ */
