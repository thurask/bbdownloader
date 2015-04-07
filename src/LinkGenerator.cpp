/*
 * LinkGenerator.cpp
 *
 *  Created on: Apr 7, 2015
 *      Author: luser
 */

#include "LinkGenerator.hpp"

LinkGenerator::LinkGenerator()
{
    generateBools();
}

void LinkGenerator::generateBools()
{
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

QString LinkGenerator::returnOsLinks()
{
    return oslinks;
}

QString LinkGenerator::returnCoreLinks()
{
    return corelinks;
}

QString LinkGenerator::returnCoreAndDebrickLinks()
{
    QString systemlinks = oslinks;
    if (!(corelinks.isEmpty())) {
        systemlinks.append("\n\n" + corelinks);
    }
    return systemlinks;
}

QString LinkGenerator::returnRadioLinks()
{
    return radiolinks;
}

QString LinkGenerator::returnLinks()
{
    return exporturls;
}

void LinkGenerator::setExportUrls(const QString& swversion, const QString& hashedswversion,
        const QString& osversion, const QString& radioversion)
{
    generateBools();
    setOsLinks(hashedswversion, osversion);
    setCoreLinks(hashedswversion, osversion);
    setRadioLinks(hashedswversion, osversion, radioversion);
    QString appversion = settings.getValueFor("appversion", "0.0.0.0");
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

void LinkGenerator::setOsLinks(const QString& hashedswversion, const QString& osversion)
{
    //Autoloaders
    if (hashedswversion == SHAHASH_NA) { //hash of "N/A"
        if (osversion != "10.3.1.634") {
            oslinks = ("---AUTOLOADERS---\n"
                    "Normal URL\n\n");
            if (osversion.indexOf("10.0") != -1 || osversion.indexOf("10.1") != -1
                    || osversion.indexOf("10.2") != -1 || osversion.indexOf("10.3.0") != -1
                    || osversion.indexOf("10.3.1.634") != -1) {
                oslinks.append(
                        "STL100-1: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-"
                                + osversion + ".exe\n\n");
            } else {
                oslinks.append(
                        "STL100-1/Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-DevAlphaB-"
                                + osversion + ".exe\n\n");
            }
            oslinks.append(
                    "STL100-2/3: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-"
                            + osversion + ".exe\n\n"
                            + "STL100-4: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-"
                            + osversion + ".exe\n\n");
            if (osversion.indexOf("10.0") == -1
                    && (osversion.indexOf("10.1") != -1 || osversion.indexOf("10.2") != -1
                            || osversion.indexOf("10.3.0") != -1
                            || osversion.indexOf("10.3.1.634") != -1)) {
                oslinks.append(
                        "SQN100-X/SQR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-1-"
                                + osversion + ".exe\n\n");
            } else if (osversion.indexOf("10.0") == -1) {
                oslinks.append(
                        "SQN100-X/SQR100-X/Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-3-DevAlphaC-"
                                + osversion + ".exe");
            } else {
                oslinks.append(""); //terminate block
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
            } else if (osversion.indexOf("10.0") == -1
                    && (osversion.indexOf("10.1") != -1 || osversion.indexOf("10.2.0") != -1)) {
                oslinks.append(
                        "Dev Alpha A_B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaA_B-"
                                + osversion + ".exe\n\n");
            } else if (osversion.indexOf("10.0") == -1 && osversion.indexOf("10.1") == -1
                    && osversion.indexOf("10.2.0") == -1
                    && (osversion.indexOf("10.2.1") != -1 || osversion.indexOf("10.3.0") != -1
                            || osversion.indexOf("10.3.1.634") != -1)) { //[10.2.1, 10.3.1.634]
                oslinks.append(
                        "Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-"
                                + osversion + ".exe\n\n");
            } else {
                oslinks.append(""); //terminate block
            }
            if (osversion.indexOf("10.0") == -1
                    && (osversion.indexOf("10.1") != -1 || osversion.indexOf("10.2") != -1
                            || osversion.indexOf("10.3.0") != -1
                            || osversion.indexOf("10.3.1.634") != -1)) { //[10.1, 10.3.1.634]
                oslinks.append(
                        "Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-"
                                + osversion + ".exe\n\n");
            }
        } else {
            oslinks =
                    ("---AUTOLOADERS---\n"
                            "Variant URL\n\n"
                            "STL100-1: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-1-"
                            + osversion + ".exe\n\n"
                            + "STL100-2/3: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-3-"
                            + osversion + ".exe\n\n"
                            + "STL100-4: http://developer.blackberry.com/native/downloads/fetch/Autoload-STL-100-4-"
                            + osversion + ".exe\n\n");
            if (osversion.indexOf("10.0.") == -1) {
                oslinks.append(
                        "SQN100-X/SQR100-X: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN-100-1-"
                                + osversion + ".exe\n\n");
            }
            if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1) {
                oslinks.append(
                        "Z30/Leap/Classic: http://developer.blackberry.com/native/downloads/fetch/Autoload-STA-100-5-"
                                + osversion + ".exe\n\n"
                                + "Z3/Kopi/Cafe: http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ-100-1-"
                                + osversion + ".exe\n\n");
            }
            if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                    && osversion.indexOf("10.2.") == -1) {
                oslinks.append(
                        "Passport: http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW-100-1-"
                                + osversion + ".exe\n\n");
            }
            if (osversion.indexOf("10.0") == -1 && osversion.indexOf("10.1") == -1
                    && osversion.indexOf("10.2") == -1) {
                oslinks.append(
                        "Dev Alpha B: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-"
                                + osversion + ".exe\n\n");
            }
            if (osversion.indexOf("10.0.") == -1) {
                oslinks.append(
                        "Dev Alpha C: http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-"
                                + osversion + ".exe");
            }
        }
    } else {
        if (osversion.indexOf("10.") != -1) {
            oslinks = ("---DEBRICK OPERATING SYSTEMS---\n");
            //STL100-1
            if (winchester == true) {
                oslinks.append(
                        "TI OMAP (STL100-1): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/"
                                + osversion + "/winchester.factory_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //8960 images
            if (qcom == true) {
                if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                        && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1) {
                    oslinks.append("Qualcomm 8960: "); //because of 8x30 hybrid
                } else {
                    oslinks.append("Qualcomm 8960/8930 (Most others): ");
                }
                oslinks.append(
                        "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + osversion
                                + "/qc8960.factory_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //8x30 images
            if (jakarta == true
                    && (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                            && osversion.indexOf("10.2.") == -1 && osversion.indexOf("10.3.0") == -1)) {
                oslinks.append(
                        "Qualcomm 8960_8x30 Hybrid (Z3): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8x30.desktop-"
                                + osversion + "-nto+armle-v7+signed.bar\n\n");
            }
            //10.3.0 specifically (Passport)
            if (passport == true && osversion.indexOf("10.3.0") != -1) {
                oslinks.append(
                        "Qualcomm 8974 (Passport): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
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
                        "Qualcomm 8960_8974 Hybrid (Passport): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974.desktop-"
                                + osversion + "-nto+armle-v7+signed.bar\n\n");
            }
            //Verizon images
            if (verizon == true) {
                oslinks.append(
                        "Verizon 8960: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + osversion
                                + "/qc8960.verizon_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //China images
            if (china == true) {
                oslinks.append(
                        "China 8960: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                + hashedswversion
                                + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + osversion
                                + "/qc8960.china_sfi.desktop-" + osversion
                                + "-nto+armle-v7+signed.bar\n\n");
            }
            //SDK images
            if (sdk == true) {
                if (qcom == true) {
                    oslinks.append(
                            "SDK 8960: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + osversion
                                    + "/qc8960.sdk.desktop-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                if (winchester == true) {
                    oslinks.append(
                            "SDK OMAP: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
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
                    "TI OMAP (PlayBook): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                    + hashedswversion + "/com.qnx.coreos.qcfm.os.factory.desktop/" + osversion
                    + "/winchester.factory_sfi.desktop-" + osversion + "-nto+armle-v7+signed.bar");
        } else {
            oslinks = "";
        }
    }
}

void LinkGenerator::setCoreLinks(const QString& hashedswversion, const QString& osversion)
{
    if (hashedswversion == SHAHASH_NA) {
        corelinks = "";
    } else {
        if (core == false) {
            corelinks = ""; //of course
        } else {
            if (osversion.indexOf("10.") != -1) {
                corelinks = ("---CORE OPERATING SYSTEMS---\n");
                //STL100-1
                if (winchester == true) {
                    corelinks.append(
                            "TI OMAP (STL100-1): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.coreos.qcfm.os.factory/"
                                    + osversion + "/winchester.factory_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //8960 images
                if (qcom == true) {
                    if (osversion.indexOf("10.0.") == -1 && osversion.indexOf("10.1.") == -1
                            && osversion.indexOf("10.2.") == -1
                            && osversion.indexOf("10.3.0") == -1) {
                        corelinks.append("Qualcomm 8960: "); //because of 8x30 hybrid
                    } else {
                        corelinks.append("Qualcomm 8960/8930 (Most others): ");
                    }
                    corelinks.append(
                            "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + hashedswversion
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
                            "Qualcomm 8960_8x30 Hybrid (Z3): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8x30-"
                                    + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
                //10.3.0 specifically (Passport)
                if (passport == true && osversion.indexOf("10.3.0") != -1) {
                    corelinks.append(
                            "Qualcomm 8974 (Passport): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
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
                            "Qualcomm 8960_8974 Hybrid (Passport): http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/qc8960.factory_sfi_hybrid_qc8974-"
                                    + osversion + "-nto+armle-v7+signed.bar\n\n");
                }
                //Verizon images
                if (verizon == true) {
                    corelinks.append(
                            "Verizon 8960: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion
                                    + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + osversion
                                    + "/qc8960.verizon_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //China images
                if (china == true) {
                    corelinks.append(
                            "China 8960: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                    + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/"
                                    + osversion + "/qc8960.china_sfi-" + osversion
                                    + "-nto+armle-v7+signed.bar\n\n");
                }
                //SDK images
                if (sdk == true) {
                    if (qcom == true) {
                        corelinks.append(
                                "SDK 8960: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
                                        + hashedswversion + "/com.qnx.coreos.qcfm.os.qc8960.sdk/"
                                        + osversion + "/qc8960.sdk-" + osversion
                                        + "-nto+armle-v7+signed.bar\n\n");
                    }
                    if (winchester == true) {
                        corelinks.append(
                                "SDK OMAP: http://cdn.fs.sl.blackberry.com/fs/qnx/production/"
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
                corelinks = ""; //not BB10 OS
            }
        }
    }
}

void LinkGenerator::setRadioLinks(const QString& hashedswversion, const QString& osversion,
        const QString& radioversion)
{
    if (hashedswversion == SHAHASH_NA) {
        radiolinks = "";
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
