/*
 * DownloadManager.cpp
 *
 *  Created on: Jun 7, 2014
 *      Author: thura_000
 */

#include "DownloadManager.hpp"
#include <bb/system/Clipboard>

#include <QtCore>

DownloadManager::DownloadManager()
{
}

void DownloadManager::setDefaultDir(QString dir)
{
    default_dir = dir;
}

QString DownloadManager::defaultDir()
{
    return default_dir;
}

void DownloadManager::setExportUrls(QString hashedswversion, QString osversion, QString radioversion)
{
    QString osurls = ("---OPERATING SYSTEMS---\n"
            "TI OMAP (STL100-1)\n"
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n" +
            "Qualcomm 8960/8930 (Most others)\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion + "/qc8960.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n" +
            "Verizon 8960/8930\n" +
            "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion + "/qc8960.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n");
    QString radiourls = ("---RADIOS---\n"
            "OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar\n\n" +
            "Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar\n\n" +
            "Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed.bar\n\n" +
            "Q10/Q5/P9983: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
    //10.2.0 and up (Z30)
    if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.0") == -1) {
        radiourls.append("Z30/Manitoba/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
    }
    //10.2.1 and up (Z3)
    if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.0") == -1 && osversion.indexOf("10.2.0") == -1) {
        radiourls.append("Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
    }
    //10.3.0 (Passport)
    if (osversion.indexOf("10.3.0") != -1) {
        osurls.append("Qualcomm 8974 (Passport)\n"
                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion + "/qc8974.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n"
                "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n");
        radiourls.append("Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr2/" + radioversion + "/qc8974.wtr2-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
    }
    //10.3.1 (Passport, again)
    if (osversion.indexOf("10.3.1") != -1) {
        osurls.append("Qualcomm 8974_8960 Hybrid (10.3.1+)\n"
                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974.desktop-" + osversion + "-nto+armle-v7+signed.bar\n" +
                "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974-" + osversion + "-nto+armle-v7+signed.bar\n\n");
        radiourls.append("Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr2/" + radioversion + "/qc8974.wtr2-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
    }
    exporturls = osurls + "\n" + radiourls;
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

void DownloadManager::saveTextFile(QString urls, QString swrelease)
{
    QDir dir(default_dir);
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    //Get local date and time
    QDateTime dateTime = QDateTime::currentDateTime();
    QString dateTimeString = dateTime.toString("yyyy_MMM_dd_hh_mm_ss");
    QFile file(default_dir+swrelease+"-"+dateTimeString+".txt");
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

QString DownloadManager::readTextFile(QString uri, QString mode)
{
    QFile file(uri);
    file.open(QIODevice::ReadOnly);
    QTextStream textStream(&file);
    QString text;
    if (mode == "normal"){
        text = textStream.readAll();
    }
    if (mode == "firstline"){
        text = textStream.readLine();
    }
    if (mode == "branch"){
        while (!textStream.atEnd()){
            QString tempstring = textStream.readLine();
            if (tempstring.startsWith("Build Branch") == true){
                text = tempstring;
            }
        }
    }
    file.close();
    return text;
}
