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

QString DownloadManager::returnOsLinks()
{
    return oslinks;
}

QString DownloadManager::returnRadioLinks()
{
    return radiolinks;
}

QString DownloadManager::returnLinks()
{
    return exporturls;
}

void DownloadManager::setOsLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester, bool passport, bool core, bool qcom)
{
    //Autoloaders
    if (hashedswversion == "08d2e98e6754af941484848930ccbaddfefe13d6"){
        oslinks = ("---AUTOLOADERS---\n"
                "Normal URL\n\n"
                "STL100-1: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-" + osversion +".exe\n\n" +
                "STL100-2/3: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-" + osversion +".exe\n\n" +
                "STL100-4: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-" + osversion +".exe\n\n" +
                "SQN100-X/SQR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-1-" + osversion +".exe\n\n" +
                "STA100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + osversion +".exe\n\n" +
                "STJ100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-" + osversion +".exe\n\n" +
                "SQW100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW100-1-" + osversion +".exe\n\n" +
                "STR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-STR100-1-" + osversion +".exe\n\n" +
                "Dev Alpha A: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlpha-" + osversion +".exe\n\n" +
                "Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-" + osversion +".exe\n\n" +
                "Dev Alpha A_B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaA_B-" + osversion +".exe\n\n" +
                "Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-" + osversion +".exe");
    }
    //To look nice, variant URLs (10.3.1.634) are in the radio links
    else {
        if (osversion.indexOf("10.") != -1){
            oslinks = ("---OPERATING SYSTEMS---\n");
            //STL100-1
            if (winchester == true){
                oslinks.append("TI OMAP (STL100-1)\n"
                        "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                if (core == true) {
                    oslinks.chop(1);
                    oslinks.append("Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/" + osversion + "/winchester.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //89x0 images
            if (qcom == true) {
                oslinks.append("Qualcomm 8960/8930 (Most others)\n"
                        "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion + "/qc8960.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                if (core == true) {
                    oslinks.chop(1);
                    oslinks.append("Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion + "/qc8960.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //Verizon images
            if (verizon == true){
                oslinks.append("Verizon 8960/8930\n"
                        "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion + "/qc8960.verizon_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                if (core == true) {
                    oslinks.chop(1);
                    oslinks.append("Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion + "/qc8960.verizon_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //10.3.0 specifically (Passport)
            if (passport == true && osversion.indexOf("10.3.0") != -1) {
                oslinks.append("Qualcomm 8974 (Passport)\n"
                        "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion + "/qc8974.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                if (core == true) {
                    oslinks.chop(1);
                    oslinks.append("Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion + "/qc8974.factory_sfi-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //10.3.1 and up (Passport, again)
            if (passport == true && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1 && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1)) {
                oslinks.append("Qualcomm 8974_8960 Hybrid (Passport)\n"
                        "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974.desktop-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                if (core == true)  {
                    oslinks.chop(1);
                    oslinks.append("Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974-" + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            oslinks.chop(2); //trailing \n\n
        }
        else if (osversion.indexOf("10.") == -1 && osversion.isEmpty() == false) {
            oslinks = ("---OPERATING SYSTEMS---\n"
                    "TI OMAP (PlayBook)\n"
                    "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar");
        }
        else {
            oslinks = "";
        }
    }
}

void DownloadManager::setRadioLinks(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester, bool passport, bool lseries, bool nseries, bool aseries, bool jakarta)
{
    if (hashedswversion == "08d2e98e6754af941484848930ccbaddfefe13d6"){
        radiolinks = ("Variant URL\n\n"
                "STL100-1: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-1-" + osversion +".exe\n\n" +
                "STL100-2/3: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-3-" + osversion +".exe\n\n" +
                "STL100-4: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-4-" + osversion +".exe\n\n" +
                "SQN100-X/SQR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN-100-1-" + osversion +".exe\n\n" +
                "STA100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-STA-100-5-" + osversion +".exe\n\n" +
                "STJ100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ-100-1-" + osversion +".exe\n\n" +
                "SQW100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW-100-1-" + osversion +".exe\n\n" +
                "STR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-STR-100-1-" + osversion +".exe\n\n" +
                "Dev Alpha A: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlpha-" + osversion +".exe\n\n" +
                "Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-" + osversion +".exe\n\n" +
                "Dev Alpha A_B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaA_B-" + osversion +".exe\n\n" +
                "Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-" + osversion +".exe");
    }
    else {
        if (osversion.indexOf("10.") != -1){
            radiolinks = ("---RADIOS---\n");
            if (winchester == true){
                radiolinks.append("OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
            }
            if (lseries == true) {
                radiolinks.append("Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
                if (verizon == true) {
                    radiolinks.append("Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/" + radioversion + "/qc8960.omadm-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //10.1 and up (Q10)
            if (nseries == true && osversion.indexOf("10.0.") == -1){
                radiolinks.append("Q10/Q5/P9983: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
            }
            //10.2.0 and up (Z30, Kopi/Cafe/Z3)
            if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1) {
                if (aseries == true) {
                    radiolinks.append("Z30/Leap/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radioversion + "/qc8960.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
                }
                if (jakarta == true) {
                    radiolinks.append("Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radioversion + "/qc8930.wtr5-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //10.3.0 and up (Passport)
            if (passport == true && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1 && osversion.indexOf("10.2.") == -1)) {
                radiolinks.append("Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr2/" + radioversion + "/qc8974.wtr2-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
            }
            radiolinks.chop(2); //trailing \n\n
        }
        //not 10.x but not empty
        else if (osversion.indexOf("10.") == -1 && osversion.isEmpty() == false){
            if (radioversion.indexOf("N/A") != -1){
                radiolinks = "";
            }
            else {
                radiolinks = ("---RADIOS---\n"
                        "PlayBook (old): http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod-qcmdm9k-" + radioversion + "-nto+armle-v7+signed.bar\n" +
                        "PlayBook (new): http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion + "/mod.qcmdm9k-" + radioversion + "-nto+armle-v7+signed.bar");
            }
        }
        else {
            radiolinks = "";
        }
    }
}

void DownloadManager::setExportUrls(QString hashedswversion, QString osversion, QString radioversion, bool verizon, bool winchester, bool passport, bool core, bool qcom, bool lseries, bool nseries, bool aseries, bool jakarta)
{
    setOsLinks(hashedswversion, osversion, verizon, winchester, passport, core, qcom);
    setRadioLinks(hashedswversion, osversion, radioversion, verizon, winchester, passport, lseries, nseries, aseries, jakarta);
    exporturls = oslinks + "\n\n" + radiolinks;
}

void DownloadManager::exportLinks(QString swrelease)
{
    saveTextFile(exporturls, swrelease);
}

void DownloadManager::copyOsLinks()
{
    QByteArray exporturls_qba = oslinks.toUtf8();
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", exporturls_qba);
}

void DownloadManager::copyRadioLinks()
{
    QByteArray exporturls_qba = radiolinks.toUtf8();
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", exporturls_qba);
}

void DownloadManager::copyLinks()
{
    QByteArray exporturls_qba = exporturls.toUtf8();
    bb::system::Clipboard clipboard;
    clipboard.clear();
    clipboard.insert("text/plain", exporturls_qba);
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
    if (mode == "normsimp"){
        text = textStream.readAll();
        text = text.simplified();
    }
    if (mode == "firstsimp"){
        text = textStream.readLine();
        text = text.simplified();
    }
    file.close();
    if (text.startsWith('\n')){
        text.remove(0, 1);
    }
    if (text.endsWith('\n')){
        text.chop(1);
    }
    return text;
}

QString DownloadManager::getcwd()
{
    return QDir::currentPath();
}
