/*
 * DownloadManager.cpp
 *
 *  Created on: Jun 7, 2014
 *      Author: thura_000
 */

#include "DownloadManager.hpp"
#include <bb/system/Clipboard>

#include <QtCore>
#include <QtNetwork>

DownloadManager::DownloadManager(QObject *parent)
: QObject(parent), m_currentDownload(0), m_downloadedCount(0), m_totalCount(0), m_progressTotal(0), m_progressValue(0)
{
}

QString DownloadManager::errorMessage() const
{
    return m_errorMessage.join("\n");
}

QString DownloadManager::statusMessage() const
{
    return m_statusMessage.join("\n");
}

int DownloadManager::activeDownloads() const
{
    return m_downloadQueue.count();
}

int DownloadManager::progressTotal() const
{
    return m_progressTotal;
}

int DownloadManager::progressValue() const
{
    return m_progressValue;
}

QString DownloadManager::progressMessage() const
{
    return m_progressMessage;
}

void DownloadManager::downloadUrl(const QString &url)
{
    append(QUrl(url));
}

void DownloadManager::append(const QUrl &url)
{
    /**
     * If there is no job in the queue at the moment or we do
     * not process any job currently, then we trigger the processing
     * of the next job.
     */
    if (m_downloadQueue.isEmpty() && !m_currentDownload)
        QTimer::singleShot(0, this, SLOT(startNextDownload()));

    // Enqueue the new URL to the job queue
    m_downloadQueue.enqueue(url);
    emit activeDownloadsChanged();

    // Increment the total number of jobs
    ++m_totalCount;
}

QString DownloadManager::saveFileName(const QUrl &url)
{
    //Create dir in downloads dir
    QDir dir("shared/downloads/bbdownloader/");
    if (!dir.exists()) {
        dir.mkpath(".");
    }

    // First extract the path component from the URL ...
    const QString path = url.path();

    // ... and then extract the file name.
    QString basename = QFileInfo(path).fileName();

    if (basename.isEmpty())
        basename = "download";

    // Replace the file name with 'download' if the URL provides no file name.

    basename = "shared/downloads/bbdownloader/" + basename;
    // locate in downloads directory

    /**
     * Check if the file name exists already, if so, append an increasing number and test again.
     */
    if (QFile::exists(basename)) {
        // already exists, don't overwrite
        int i = 0;
        basename += '.';
        while (QFile::exists(basename + QString::number(i)))
            ++i;

        basename += QString::number(i);
    }

    return basename;
}

void DownloadManager::addErrorMessage(const QString &message)
{
    m_errorMessage.append(message);
    emit errorMessageChanged();
}

void DownloadManager::addStatusMessage(const QString &message)
{
    m_statusMessage.append(message);
    emit statusMessageChanged();
}

void DownloadManager::startNextDownload()
{
    // If the queue is empty just add a new status message
    if (m_downloadQueue.isEmpty()) {
        addStatusMessage(QString("%1/%2 files downloaded successfully").arg(m_downloadedCount).arg(m_totalCount));
        return;
    }

    // Otherwise dequeue the first job from the queue ...
    const QUrl url = m_downloadQueue.dequeue();

    // ... and determine a local file name where the result can be stored.
    const QString filename = saveFileName(url);

    // Open the file with this file name for writing
    m_output.setFileName(filename);
    if (!m_output.open(QIODevice::WriteOnly)) {
        addErrorMessage(QString("Problem opening save file '%1' for download '%2': %3").arg(filename, url.toString(), m_output.errorString()));

        startNextDownload();
        return; // skip this download
    }

    // Now create the network request for the URL ...
    QNetworkRequest request(url);
    request.setAttribute(QNetworkRequest::HttpPipeliningAllowedAttribute, true);

    // ... and start the download.
    m_currentDownload = m_manager.get(request);

    // Connect against the necessary signals to get informed about progress and status changes
    connect(m_currentDownload, SIGNAL(downloadProgress(qint64, qint64)),
            SLOT(downloadProgress(qint64, qint64)));
    connect(m_currentDownload, SIGNAL(finished()), SLOT(downloadFinished()));
    connect(m_currentDownload, SIGNAL(readyRead()), SLOT(downloadReadyRead()));

    // Add a status message
    addStatusMessage(QString("Downloading %1...").arg(url.toString()));

    // Start the timer so that we can calculate the download speed later on
    m_downloadTime.start();
}

void DownloadManager::downloadProgress(qint64 bytesReceived, qint64 bytesTotal)
{
    // Update the properties with the new progress values
    m_progressTotal = bytesTotal;
    m_progressValue = bytesReceived;
    emit progressTotalChanged();
    emit progressValueChanged();

    // Calculate the download speed ...
    double speed = bytesReceived * 1000.0 / m_downloadTime.elapsed();
    QString unit;
    if (speed < 1024) {
        unit = "bytes/sec";
    } else if (speed < 1024 * 1024) {
        speed /= 1024;
        unit = "kB/s";
    } else {
        speed /= 1024 * 1024;
        unit = "MB/s";
    }

    // ... and update the progress message.
    m_progressMessage = QString("%1 %2").arg(speed, 3, 'f', 1).arg(unit);
    emit progressMessageChanged();
}

void DownloadManager::downloadFinished()
{
    // Reset the progress information when the download has finished
    m_progressTotal = 0;
    m_progressValue = 0;
    m_progressMessage.clear();
    emit progressValueChanged();
    emit progressTotalChanged();
    emit progressMessageChanged();

    // Close the file where the data have been written
    m_output.close();

    // Add a status or error message
    if (m_currentDownload->error()) {
        addErrorMessage(QString("Failed: %1").arg(m_currentDownload->errorString()));
        //delete temp file
        m_output.remove();
    } else {
        addStatusMessage("Succeeded.");
        ++m_downloadedCount;
    }

    /**
     * We can't call 'delete m_currentDownload' here, because this method might have been invoked directly as result of a signal
     * emission of the network reply object.
     */
    m_currentDownload->deleteLater();
    m_currentDownload = 0;
    emit activeDownloadsChanged();

    // Trigger the execution of the next job
    startNextDownload();
}

void DownloadManager::downloadReadyRead()
{
    // Whenever new data are available on the network reply, write them out to the result file
    m_output.write(m_currentDownload->readAll());
}

void DownloadManager::downloadCancelled()
{
    m_currentDownload->abort();

    // Reset the progress information when the download has finished
    m_progressTotal = 0;
    m_progressValue = 0;
    m_progressMessage.clear();
    emit progressValueChanged();
    emit progressTotalChanged();
    emit progressMessageChanged();

    // Delete the file where the data have been written
    m_output.close();
    m_output.remove();

    /**
     * We can't call 'delete m_currentDownload' here, because this method might have been invoked directly as result of a signal
     * emission of the network reply object.
     */
    m_currentDownload->deleteLater();
    m_currentDownload = 0;
    emit activeDownloadsChanged();
}

void DownloadManager::messagesCleared()
{
    //Clear status messages
    m_errorMessage.clear();
    m_statusMessage.clear();
    emit errorMessageChanged();
    emit statusMessageChanged();
}

void DownloadManager::setExportUrls(QString hashedswversion, QString osversion, QString radioversion)
{
    exporturls = ("---OPERATING SYSTEMS---\n"
            "STL100-1\n"
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n" +
            "Qualcomm 8960/8930 (Most others)\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion + "/qc8960.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n" +
            "Verizon Devices\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion + "/qc8960.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n\n" +
            "Qualcomm 8974 (Passport)\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion + "/qc8974.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "\n\n" +
            "---RADIOS---\n" +
            "OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Q10/Q5/P9983: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Z30/Manitoba/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr2/" + radioversion + "/qc8974.wtr2-" + radioversion + "-nto+armle-v7+signed.bar\n" +
            "");
}

void DownloadManager::exportLinks(QString swrelease, QString hashedswversion, QString osversion, QString radioversion)
{
    setExportUrls(hashedswversion, osversion, radioversion);
    saveTextFile(exporturls, swrelease);
}

void DownloadManager::copyLinks(QString hashedswversion, QString osversion, QString radioversion)
{
    setExportUrls(hashedswversion, osversion, radioversion);
    QByteArray exporturls_qba = exporturls.toUtf8();
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", exporturls_qba);
}

QString DownloadManager::returnLinks(QString hashedswversion, QString osversion, QString radioversion)
{
    setExportUrls(hashedswversion, osversion, radioversion);
    return exporturls;
}

void DownloadManager::setExportUrlsDelta(QString hashedswversion, QString osversion, QString radioversion, QString osinit, QString osinit2, QString radinit, QString radinit2)
{
    exporturlsdelta = ("---OPERATING SYSTEMS---\n"
                "STL100-1\n"
                "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.d" + osinit + "/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n" +
                "Qualcomm 8960\n" +
                "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory.d" + osinit + "/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n" +
                "Verizon\n" +
                "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon.d" + osinit + "/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n" +
                "Qualcomm 8974\n" +
                "Delta OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory.d" + osinit + "/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar\n\n" +
                "---RADIOS---\n" +
                "OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730.d" + radinit + "/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.d" + radinit + "/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm.d" + radinit + "/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "Q10/Q5/P9983: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr.d" + radinit + "/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "Z30/Manitoba/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5.d" + radinit + "/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5.d" + radinit + "/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr2.d" + radinit + "/" + radioversion + "/qc8974.wtr2-" + radioversion + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar\n" +
                "");
}

void DownloadManager::exportDeltaLinks(QString hashedswversion, QString osversion, QString radioversion, QString osinitversion, QString osinit, QString osinit2, QString radinit, QString radinit2)
{
    setExportUrlsDelta(hashedswversion, osversion, radioversion, osinit, osinit2, radinit, radinit2);
    QString deltasw = osinitversion + "-to-" + osversion;
    saveTextFile(exporturlsdelta, deltasw);
}

void DownloadManager::copyDeltaLinks(QString hashedswversion, QString osversion, QString radioversion, QString osinit, QString osinit2, QString radinit, QString radinit2)
{
    setExportUrlsDelta(hashedswversion, osversion, radioversion, osinit, osinit2, radinit, radinit2);
    QByteArray exporturlsdelta_qba = exporturlsdelta.toUtf8();
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", exporturlsdelta_qba);
}

QString DownloadManager::returnDeltaLinks(QString hashedswversion, QString osversion, QString radioversion, QString osinit, QString osinit2, QString radinit, QString radinit2)
{
    setExportUrlsDelta(hashedswversion, osversion, radioversion, osinit, osinit2, radinit, radinit2);
    return exporturlsdelta;
}

void DownloadManager::saveTextFile(QString urls, QString swrelease)
{
    QDir dir("shared/downloads/bbdownloader/");
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    //Get local date and time
    QDateTime dateTime = QDateTime::currentDateTime();
    QString dateTimeString = dateTime.toString("yyyy_MMM_dd_hh_mm_ss");
    QFile file("shared/downloads/bbdownloader/"+swrelease+"--"+dateTimeString+".txt");
    QFileInfo fi(file);
    filename = fi.absoluteFilePath();
    file.open(QIODevice::WriteOnly);
    QTextStream outStream(&file);
    outStream << urls;
    file.close();
}

QString DownloadManager::returnFilename()
{
    return "file://" + filename;
}

QString DownloadManager::readTextFile(QString uri)
{
    QFile file(uri);
    file.open(QIODevice::ReadOnly);
    QTextStream textStream(&file);
    QString text = textStream.readAll();
    file.close();
    return text;
}
