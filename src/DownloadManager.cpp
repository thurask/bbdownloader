#include "DownloadManager.hpp"
#include "Settings.hpp"
#include <bb/system/Clipboard>
#include <bb/ApplicationInfo>

DownloadManager::DownloadManager()
{
    bb::ApplicationInfo appInfo;
    appversion = appInfo.version();
    generateBools();
}

void DownloadManager::generateBools()
{
    Settings settings;
    verizon = (settings.getValueFor("verizon", "true") == "true"); //convert string to boolean, hehe
    core = (settings.getValueFor("core", "true") == "true");
    qcom = (settings.getValueFor("qcom", "true") == "true");
    winchester = (settings.getValueFor("winchester", "true") == "true");
    passport = (settings.getValueFor("passport", "true") == "true");
    lseries = (settings.getValueFor("lseries", "true") == "true");
    nseries = (settings.getValueFor("nseries", "true") == "true");
    aseries = (settings.getValueFor("aseries", "true") == "true");
    jakarta = (settings.getValueFor("jakarta", "true") == "true");
    laguna = (settings.getValueFor("laguna", "true") == "true");
    aquarius = (settings.getValueFor("aquarius", "false") == "true");
    china = (settings.getValueFor("china", "false") == "true");
    sdk = (settings.getValueFor("sdk", "false") == "true");
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

QString DownloadManager::returnCoreLinks()
{
    return corelinks;
}

QString DownloadManager::returnRadioLinks()
{
    return radiolinks;
}

QString DownloadManager::returnLinks()
{
    return exporturls;
}

void DownloadManager::setOsLinks(QString hashedswversion, QString osversion)
{
    //Autoloaders
    if (hashedswversion == "08d2e98e6754af941484848930ccbaddfefe13d6") { //hash of "N/A"
        oslinks =
                ("---AUTOLOADERS---\n"
                        "Normal URL\n\n"
                        "STL100-1: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-"
                        + osversion + ".exe\n\n"
                        + "STL100-2/3: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-"
                        + osversion + ".exe\n\n"
                        + "STL100-4: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-"
                        + osversion + ".exe\n\n");
        if (osversion.indexOf("10.0.") == -1) {
            oslinks.append(
                    "SQN100-X/SQR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-1-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1) {
            oslinks.append(
                    "Z30/Leap/Classic: http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-"
                            + osversion + ".exe\n\n"
                            + "Z3/Kopi/Cafe: http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                && osversion.indexOf("10.2.") == -1) {
            oslinks.append(
                    "Passport: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW100-1-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0") != -1) {
            oslinks.append(
                    "Dev Alpha A: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlpha-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0") == -1
                && (osversion.indexOf("10.1") != -1 || osversion.indexOf("10.2.0") != -1)) {
            oslinks.append(
                    "Dev Alpha A_B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaA_B-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0") == -1 && osversion.indexOf("10.1") == -1
                && osversion.indexOf("10.2.0") == -1) {
            oslinks.append(
                    "Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0.") == -1) {
            oslinks.append(
                    "Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-"
                            + osversion + ".exe");
        }
    } else {
        if (osversion.indexOf("10.") != -1) {
            oslinks = ("---DEBRICK OPERATING SYSTEMS---\n");
            //STL100-1
            if (winchester == true) {
                oslinks.append(
                        "TI OMAP (STL100-1)\n"
                                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/"
                                + osversion + "/winchester.factory_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //8960 images
            if (qcom == true) {
                if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                        && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1) {
                    oslinks.append("Qualcomm 8960\n"); //because of 8x30 hybrid
                } else {
                    oslinks.append("Qualcomm 8960/8930 (Most others)\n");
                }
                oslinks.append(
                        "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion
                                + "/qc8960.factory_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //8x30 images
            if (jakarta == true
                    && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                            && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1)) {
                oslinks.append(
                        "Qualcomm 8960_8x30 Hybrid (Z3)\n"
                                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8x30.desktop-"
                                + osversion + "-nto+armle-v7+signed.bar\n\n");
            }
            //10.3.0 specifically (Passport)
            if (passport == true && osversion.indexOf("10.3.0") != -1) {
                oslinks.append(
                        "Qualcomm 8974 (Passport)\n"
                                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + osversion
                                + "/qc8974.factory_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //10.3.1 and up (Passport, again)
            if (passport == true
                    && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                            && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1)) {
                oslinks.append(
                        "Qualcomm 8960_8974 Hybrid (Passport)\n"
                                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974.desktop-"
                                + osversion + "-nto+armle-v7+signed.bar\n\n");
            }
            //Verizon images
            if (verizon == true) {
                oslinks.append(
                        "Verizon 8960\n"
                                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion
                                + "/qc8960.verizon_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //China images
            if (china == true) {
                oslinks.append(
                        "China 8960\n"
                                "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osversion
                                + "/qc8960.china_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //SDK images
            if (sdk == true) {
                if (qcom == true) {
                    oslinks.append(
                            "SDK 8960\n"
                                    "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osversion
                                    + "/qc8960.sdk.desktop-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                if (winchester == true) {
                    oslinks.append(
                            "SDK OMAP\n"
                                    "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.winchester.sdk.desktop/" + osversion
                                    + "/winchester.sdk.desktop-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            oslinks.chop(2); //trailing \n\n
            if (oslinks.endsWith("S--") == true) {
                oslinks.append("-"); //re-add chopped off dash in title, if it's there
            }
        } else if (osversion.indexOf("10.") == -1 && osversion.isEmpty() == false) {
            oslinks = ("---OPERATING SYSTEMS---\n"
                    "TI OMAP (PlayBook)\n"
                    "Debrick OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                    + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion
                    + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar");
        } else {
            oslinks = "";
        }
    }
}

void DownloadManager::setCoreLinks(QString hashedswversion, QString osversion)
{
    if (hashedswversion == "08d2e98e6754af941484848930ccbaddfefe13d6") {
        if ((osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1)
                && osversion.indexOf("10.3.1.634") == -1) { //please stop changing these names, BlackBerry
            corelinks =
                    ("STL100-1/Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-DevAlphaB-"
                            + osversion + ".exe\n\n"
                            + "SQN100-X/SQR100-X/Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-3-DevAlphaC-"
                            + osversion + ".exe\n\n");
        } else {
            corelinks = "";
        }
    } else {
        if (core == false) {
            corelinks = "";
        } else {
            if (osversion.indexOf("10.") != -1) {
                corelinks = ("---CORE OPERATING SYSTEMS---\n");
                //STL100-1
                if (winchester == true) {
                    corelinks.append(
                            "TI OMAP (STL100-1)\n"
                                    "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/"
                                    + osversion + "/winchester.factory_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //8960 images
                if (qcom == true) {
                    if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                            && osversion.indexOf("10.2.") == -1
                            && osversion.indexOf("10.3.0") == -1) {
                        corelinks.append("Qualcomm 8960\n"); //because of 8x30 hybrid
                    } else {
                        corelinks.append("Qualcomm 8960/8930 (Most others)\n");
                    }
                    corelinks.append(
                            "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + osversion
                                    + "/qc8960.factory_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //8x30 images
                if (jakarta == true
                        && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                                && osversion.indexOf("10.2.") == -1
                                && osversion.indexOf("10.3.0") == -1)) {
                    corelinks.append(
                            "Qualcomm 8960_8x30 Hybrid (Z3)\n"
                                    "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8x30-"
                                    + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
                //10.3.0 specifically (Passport)
                if (passport == true && osversion.indexOf("10.3.0") != -1) {
                    corelinks.append(
                            "Qualcomm 8974 (Passport)\n"
                                    "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + osversion
                                    + "/qc8974.factory_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //10.3.1 and up (Passport, again)
                if (passport == true
                        && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                                && osversion.indexOf("10.2.") == -1
                                && osversion.indexOf("10.3.0") == -1)) {
                    corelinks.append(
                            "Qualcomm 8960_8974 Hybrid (Passport)\n"
                                    "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974-"
                                    + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
                //Verizon images
                if (verizon == true) {
                    corelinks.append(
                            "Verizon 8960\n"
                                    "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion
                                    + "/qc8960.verizon_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //China images
                if (china == true) {
                    corelinks.append(
                            "China 8960\n"
                                    "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/"
                                    + osversion + "/qc8960.china_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //SDK images
                if (sdk == true) {
                    if (qcom == true) {
                        corelinks.append(
                                "SDK 8960\n"
                                        "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                        + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/"
                                        + osversion + "/qc8960.sdk-" + osversion
                                        + "-nto+armle-v7+signed.bar\n\n");
                    }
                    if (winchester == true) {
                        corelinks.append(
                                "SDK OMAP\n"
                                        "Core OS: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                        + hashedswversion
                                        + "/com.qnx.coreos.qcfm.os.winchester.sdk/" + osversion
                                        + "/winchester.sdk-" + osversion
                                        + "-nto+armle-v7+signed.bar\n\n");
                    }
                }
                corelinks.chop(2); //trailing \n\n
                if (corelinks.endsWith("S--") == true) {
                    corelinks.append("-"); //re-add chopped off dash in title, if it's there
                }
            } else {
                corelinks = "";
            }
        }
    }
}

void DownloadManager::setRadioLinks(QString hashedswversion, QString osversion,
        QString radioversion)
{
    if (hashedswversion == "08d2e98e6754af941484848930ccbaddfefe13d6") {
        radiolinks =
                ("---AUTOLOADERS---\n"
                        "Variant URL\n\n"
                        "STL100-1: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-1-"
                        + osversion + ".exe\n\n"
                        + "STL100-2/3: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-3-"
                        + osversion + ".exe\n\n"
                        + "STL100-4: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-4-"
                        + osversion + ".exe\n\n");
        if (osversion.indexOf("10.0.") == -1) {
            radiolinks.append(
                    "SQN100-X/SQR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN-100-1-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1) {
            radiolinks.append(
                    "Z30/Leap/Classic: http://developer.blackberry.com/native/downloads/fetch/Autoload-STA-100-5-"
                            + osversion + ".exe\n\n"
                            + "Z3/Kopi/Cafe: http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ-100-1-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                && osversion.indexOf("10.2.") == -1) {
            radiolinks.append(
                    "Passport: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW-100-1-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0") == -1 && osversion.indexOf("10.1") == -1
                && osversion.indexOf("10.2") == -1) {
            radiolinks.append(
                    "Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-"
                            + osversion + ".exe\n\n");
        }
        if (osversion.indexOf("10.0.") == -1) {
            radiolinks.append(
                    "Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-"
                            + osversion + ".exe");
        }
    } else {
        if (osversion.indexOf("10.") != -1) {
            radiolinks = ("---RADIOS---\n");
            if (winchester == true) {
                radiolinks.append(
                        "OMAP Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.qcfm.radio.m5730/" + radioversion
                                + "/m5730-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
            }
            if (lseries == true) {
                radiolinks.append(
                        "Qualcomm Z10/P9982: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.qcfm.radio.qc8960/" + radioversion
                                + "/qc8960-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
            }
            if (laguna == true) {
                radiolinks.append(
                        "Verizon Z10: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.qcfm.radio.qc8960.omadm/"
                                + radioversion + "/qc8960.omadm-" + radioversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //10.1 and up (Q10)
            if (nseries == true && osversion.indexOf("10.0.") == -1) {
                radiolinks.append(
                        "Q10/Q5/P9983: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr/" + radioversion
                                + "/qc8960.wtr-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
            }
            //10.2.0 and up (Z30, Kopi/Cafe/Z3)
            if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1) {
                if (aseries == true) {
                    radiolinks.append(
                            "Z30/Leap/Classic: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.qcfm.radio.qc8960.wtr5/"
                                    + radioversion + "/qc8960.wtr5-" + radioversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                if (jakarta == true) {
                    radiolinks.append(
                            "Z3/Kopi/Cafe: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.qcfm.radio.qc8930.wtr5/"
                                    + radioversion + "/qc8930.wtr5-" + radioversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                if (aquarius == true) {
                    radiolinks.append(
                            "AQ Series: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.qcfm.radio.qc8974/" + radioversion
                                    + "/qc8974-" + radioversion + "-nto+armle-v7+signed.bar\n\n");
                }
            }
            //10.3.0 and up (Passport)
            if (passport == true
                    && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                            && osversion.indexOf("10.2.") == -1)) {
                radiolinks.append(
                        "Passport: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.qcfm.radio.qc8974.wtr2/"
                                + radioversion + "/qc8974.wtr2-" + radioversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            radiolinks.chop(2); //trailing \n\n
            if (radiolinks.endsWith("S--") == true) {
                radiolinks.append("-"); //re-add chopped off dash in title, if it's there
            }
        }
        //not 10.x but not empty
        else if (osversion.indexOf("10.") == -1 && osversion.isEmpty() == false) {
            if (radioversion.indexOf("N/A") != -1) {
                radiolinks = "";
            } else {
                radiolinks = ("---RADIOS---\n"
                        "PlayBook (old): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                        + hashedswversion + "/mod-qcmdm9k-" + radioversion
                        + "-nto+armle-v7+signed.bar\n"
                        + "PlayBook (new): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                        + hashedswversion + "/mod.qcmdm9k-" + radioversion
                        + "-nto+armle-v7+signed.bar");
            }
        } else {
            radiolinks = "";
        }
    }
}

void DownloadManager::setExportUrls(QString swversion, QString hashedswversion, QString osversion,
        QString radioversion)
{
    generateBools();
    setOsLinks(hashedswversion, osversion);
    setCoreLinks(hashedswversion, osversion); // if core == true, dummy == false and vice versa
    setRadioLinks(hashedswversion, osversion, radioversion);
    exporturls = "~~~POTENTIAL LINKS~~~\n";
    exporturls.append(
            "OS " + osversion + " | RADIO " + radioversion + "\nSOFTWARE RELEASE " + swversion
                    + "\n\n");
    exporturls.append(oslinks + "\n\n");
    if (core == true) {
        exporturls.append(corelinks + "\n\n");
    }
    exporturls.append(radiolinks);
    exporturls.append("\n\n~~~~~~~~\nGenerated with BBDownloader " + appversion);
    exporturls.append("\nhttps://github.com/thurask/bbdownloader");
}

void DownloadManager::exportLinks(QString swrelease)
{
    saveTextFile(exporturls, swrelease);
}

void DownloadManager::copyOsLinks()
{
    QString systemlinks = oslinks;
    if (!(corelinks.isEmpty())) {
        systemlinks.append("\n\n" + corelinks);
    }
    QByteArray exporturls_qba = systemlinks.toUtf8();
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
    QFile file(default_dir + swrelease + "-" + dateTimeString + ".txt");
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

QString DownloadManager::getcwd()
{
    return QDir::currentPath();
}
