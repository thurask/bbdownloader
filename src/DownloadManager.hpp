/*
 * DownloadManager.hpp
 *
 *  Created on: Jun 7, 2014
 *      Author: thura_000
 */

#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

#include <QtCore/QFile>
    #include <QtCore/QObject>
    #include <QtCore/QQueue>
    #include <QtCore/QStringList>
    #include <QtCore/QTime>
    #include <QtCore/QUrl>
    #include <QtNetwork/QNetworkAccessManager>
    #include <QtCore/QDir>

    class QNetworkReply;

    /**
     * The DownloadManager encapsulates the download and saving of URLs.
     * Error and status messages are available to the UI via properties as well as the number
     * of currently running downloads.
     * Additionally it provides progress information for the currently running download.
     */
    class DownloadManager : public QObject
    {
        Q_OBJECT

        // Makes error messages available to the UI
        Q_PROPERTY(QString errorMessage READ errorMessage NOTIFY errorMessageChanged)

        // Makes status messages available to the UI
        Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusMessageChanged)

        // Makes the number of currently running downloads available to the UI
        Q_PROPERTY(int activeDownloads READ activeDownloads NOTIFY activeDownloadsChanged)

        // Makes the total number of bytes of the current download available to the UI
        Q_PROPERTY(int progressTotal READ progressTotal NOTIFY progressTotalChanged)

        // Makes the already downloaded number of bytes of the current download available to the UI
        Q_PROPERTY(int progressValue READ progressValue NOTIFY progressValueChanged)

        // Makes the progress message available to the UI
        Q_PROPERTY(QString progressMessage READ progressMessage NOTIFY progressMessageChanged)

    public:
        DownloadManager(QObject *parent = 0);

        // The accessor methods for the properties
        QString errorMessage() const;
        QString statusMessage() const;
        int activeDownloads() const;
        int progressTotal() const;
        int progressValue() const;
        QString progressMessage() const;

    public Q_SLOTS:
        // This method is called when the user starts a download by clicking the 'Download' button in the UI
        void downloadUrl(const QString &url);

    Q_SIGNALS:
        // The change notification signals of the properties
        void errorMessageChanged();
        void statusMessageChanged();
        void activeDownloadsChanged();
        void progressTotalChanged();
        void progressValueChanged();
        void progressMessageChanged();

    private Q_SLOTS:
        // This method starts the next download from the internal job queue
        void startNextDownload();

        // This method is called whenever the progress of the current download job has changed
        void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);

        // This method is called whenever a download job has finished
        void downloadFinished();

        // This method is called whenever the current download job received new data
        void downloadReadyRead();

    private:
        // Enqueues a new download to the internal job queue
        void append(const QUrl &url);

        // This method determines a file name that can be used to save the given URL
        QString saveFileName(const QUrl &url);

        // A helper method to collect error messages
        void addErrorMessage(const QString &message);

        // A helper method to collect status messages
        void addStatusMessage(const QString &message);

        // The network access manager that does all the network communication
        QNetworkAccessManager m_manager;

        // The internal job queue
        QQueue<QUrl> m_downloadQueue;

        // The currently running download job
        QNetworkReply *m_currentDownload;

        // The file where the downloaded data are saved
        QFile m_output;

        // The time when the download started (used to calculate download speed)
        QTime m_downloadTime;

        // The number of finished download jobs
        int m_downloadedCount;

        // The total number of download jobs
        int m_totalCount;

        // The total number of bytes to transfer for the current download job
        int m_progressTotal;

        // The number of already transferred bytes for the current download job
        int m_progressValue;

        // A textual representation of the current progress status
        QString m_progressMessage;

        // The list of error messages
        QStringList m_errorMessage;

        // The list of status messages
        QStringList m_statusMessage;
    };

#endif /* DOWNLOADMANAGER_HPP_ */
