#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

    #include <QtCore>

    class DownloadManager : public QObject
    {
        Q_OBJECT

    public:
        DownloadManager();

    public Q_SLOTS:

        QString returnOsLinks();

        QString returnRadioLinks();

        void setExportUrls(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester, bool passport, bool core, bool qcom, bool lseries, bool nseries, bool aseries, bool jakarta);

        void setOsLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester, bool passport, bool core, bool qcom);

        void setRadioLinks(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester, bool passport, bool lseries, bool nseries, bool aseries, bool jakarta);

        void saveTextFile(QString urls, QString swrelease);

        void exportLinks(QString swrelease);

        void copyLinks();

        void copyOsLinks();

        void copyRadioLinks();

        QString returnLinks();

        QString returnFilename();

        QString readTextFile(QString uri, QString mode);

        void setDefaultDir(QString dir);

        QString defaultDir();

    private:

        QString exporturls;

        QString radiolinks;

        QString oslinks;

        QString filename;

        QString default_dir;
    };

#endif /* DOWNLOADMANAGER_HPP_ */
