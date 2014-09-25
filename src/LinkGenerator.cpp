/*LinkGenerator.cpp
--------------------
Handles link generation and related operations.

--Thurask*/

#include "LinkGenerator.hpp"
#include <QtCore>

LinkGenerator::LinkGenerator()
{

}

void LinkGenerator::setAutoloader(QString os, QString device)
{
    radioLink = "";
    if (device == "winchester"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-1-" + os +".exe";
    }
    if (device == "winchester_daa"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlpha-" + os +".exe";
    }
    if (device == "winchester_dab"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaB-" + os +".exe";
    }
    if (device == "winchester_daab"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaA_B-" + os +".exe";
    }
    if (device == "8960"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-3-" + os +".exe";
    }
    if (device == "8960omadm"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STL100-4-" + os +".exe";
    }
    if (device == "8960wtr"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQN100-5-" + os +".exe";
    }
    if (device == "8960wtr_dac"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-DevAlphaC-" + os +".exe";
    }
    if (device == "8960wtr5"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STA100-5-" + os +".exe";
    }
    if (device == "8930wtr5"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-STJ100-1-" + os +".exe";
    }
    if (device == "8974_sqw"){
        osLink = "http://developer.blackberry.com/native/downloads/fetch/Autoload-SQW100-1-" + os +".exe";
    }
}

void LinkGenerator::setOS(QString os, QString swrelease, QString type, QString device)
{
    if (device == "8960" || device == "8960omadm" || device == "8960wtr" ||  device == "8960wtr_dac" || device == "8960wtr5" || device == "8930wtr5"){
        if (type == "debrick"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi.desktop/" + os + "/qc8960.factory_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.factory_sfi/" + os + "/qc8960.factory_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "debrick_vzw"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi.desktop/" + os + "/qc8960.verizon_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core_vzw"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.verizon_sfi/" + os + "/qc8960.verizon_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "debrick_china"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi.desktop/" + os + "/qc8960.china_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core_china"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.china_sfi/" + os + "/qc8960.china_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "sdkdebrick"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.sdk.desktop/" + os + "/qc8960.sdk.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "sdkcore"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.sdk/" + os + "/qc8960.sdk-" + os + "-nto+armle-v7+signed.bar";
        }
    }
    if (device == "winchester" || device == "winchester_daa" || device == "winchester_dab" || device == "winchester_daab" || device == "winchester_pb" || device == "winchester_pblte_old" || device == "winchester_pblte_new"){
        if (type == "debrick"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.factory.desktop/" + os + "/winchester.factory_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.factory/" + os + "/winchester.factory_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "sdkdebrick"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.winchester.sdk.desktop/" + os + "/winchester.sdk.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "sdkcore"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.winchester.sdk/" + os + "/winchester.sdk-" + os + "-nto+armle-v7+signed.bar";
        }
    }
    if (device == "8974" || device == "8974_sqw"){
        if (type == "debrick"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi.desktop/" + os + "/qc8974.factory_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.factory_sfi/" + os + "/qc8974.factory_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "debrick_vzw"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.verizon_sfi.desktop/" + os + "/qc8974.verizon_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core_vzw"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.verizon_sfi/" + os + "/qc8974.verizon_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "debrick_china"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.china_sfi.desktop/" + os + "/qc8974.china_sfi.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "core_china"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.china_sfi/" + os + "/qc8974.china_sfi-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "sdkdebrick"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.sdk.desktop/" + os + "/qc8974.sdk.desktop-" + os + "-nto+armle-v7+signed.bar";
        }
        if (type == "sdkcore"){
            osLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.sdk/" + os + "/qc8974.sdk-" + os + "-nto+armle-v7+signed.bar";
        }
    }
}

void LinkGenerator::setRadio(QString radio, QString swrelease, QString device)
{
    if (device == "winchester" || device == "winchester_daa" || device == "winchester_dab" || device == "winchester_daab"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.m5730/" + radio + "/m5730-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "winchester_pblte_old"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/mod-qcmdm9k-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "winchester_pblte_new"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/mod.qcmdm9k-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "winchester_pb"){
        radioLink = "";
    }
    if (device == "8960"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960/" + radio + "/qc8960-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "8960omadm"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.omadm/" + radio + "/qc8960.omadm-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "8960wtr" || device == "8960wtr_dac"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.wtr/" + radio + "/qc8960.wtr-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "8960wtr5"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.wtr5/" + radio + "/qc8960.wtr5-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "8930wtr5"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8930.wtr5/" + radio + "/qc8930.wtr5-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "8974_sqw"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8974.wtr2/" + radio + "/qc8974.wtr2-" + radio + "-nto+armle-v7+signed.bar";
    }
    if (device == "8974"){
        radioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8974/" + radio + "/qc8974-" + radio + "-nto+armle-v7+signed.bar";
    }
}

void LinkGenerator::setDeltaOS(QString os, QString initialos, QString swrelease, QString type, QString device)
{
    QString osinit = initialos.replace(".","");
    QString osinit2 = initialos.replace(".","_");
    if (device == "8960" || device == "8960omadm" || device == "8960wtr" || device == "8960wtr5" || device == "8930wtr5"){
        if (type == "core"){
            deltaOsLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.factory.d" + osinit + "/" + os + "/qc8960.factory_sfi-" + os + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
        if (type == "core_vzw"){
            deltaOsLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8960.verizon.d" + osinit + "/" + os + "/qc8960.verizon_sfi-" + os + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
    }
    if (device == "winchester"){
        deltaOsLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.factory.d" + osinit + "/" + os + "/winchester.factory_sfi-" + os + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
    }
    if (device == "8974_sqw"){
        if (type == "core"){
            deltaOsLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.factory.d" + osinit + "/" + os + "/qc8974.factory_sfi-" + os + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
        if (type == "core_vzw"){
            deltaOsLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.coreos.qcfm.os.qc8974.verizon.d" + osinit + "/" + os + "/qc8974.verizon_sfi-" + os + "-nto+armle-v7+signed+patch+"+ osinit2 + ".bar";
        }
    }
}

void LinkGenerator::setDeltaRadio(QString radio, QString initialradio, QString swrelease, QString device)
{
    QString radinit = initialradio.replace(".","");
    QString radinit2 = initialradio.replace(".","_");
    if (device == "winchester"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.m5730.d" + radinit + "/" + radio + "/m5730-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
    if (device == "8960"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.d" + radinit + "/" + radio + "/qc8960-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
    if (device == "8960omadm"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.omadm.d" + radinit + "/" + radio + "/qc8960.omadm-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
    if (device == "8960wtr"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.wtr.d" + radinit + "/" + radio + "/qc8960.wtr-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
    if (device == "8960wtr5"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8960.wtr5.d" + radinit + "/" + radio + "/qc8960.wtr5-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
    if (device == "8930wtr5"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8930.wtr5.d" + radinit + "/" + radio + "/qc8930.wtr5-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
    if (device == "8974_sqw"){
        deltaRadioLink = "http://cdn.fs.sl.blackberry.com/fs/qnx/production/" + swrelease + "/com.qnx.qcfm.radio.qc8974.wtr2.d" + radinit + "/" + radio + "/qc8974.wtr2-" + radio + "-nto+armle-v7+signed+patch+"+ radinit2 + ".bar";
    }
}

void LinkGenerator::setOsLabel(QString type)
{
    if (type == "debrick"){
        osLabel = tr("Debrick OS:");
    }
    if (type == "core"){
        osLabel = tr("Core OS:");
    }
    if (type == "debrick_vzw"){
        osLabel = tr("Verizon Debrick OS:");
    }
    if (type == "core_vzw"){
        osLabel = tr("Verizon Core OS:");
    }
    if (type == "debrick_china"){
        osLabel = tr("China Debrick OS:");
    }
    if (type == "core_china"){
        osLabel = tr("China Core OS:");
    }
    if (type == "sdkdebrick"){
        osLabel = tr("SDK Debrick OS:");
    }
    if (type == "sdkcore"){
        osLabel = tr("SDK Core OS:");
    }
    if (type == "sdkautoloader"){
        osLabel = tr("SDK Autoloader:");
    }
}

void LinkGenerator::setRadioLabel(QString device)
{
    if (device == "winchester" || device == "winchester_daa" || device == "winchester_dab" || device == "winchester_daab"){
        radioLabel = tr("OMAP Z10/Dev Alpha A/B Radio:");
    }
    if (device == "winchester_pblte_old"){
        radioLabel = tr("4G PlayBook Radio (mod-qcmdm):");
    }
    if (device == "winchester_pblte_new"){
        radioLabel = tr("4G PlayBook Radio (mod.qcmdm):");
    }
    if (device == "winchester_pb"){
        radioLabel = "";
    }
    if (device == "8960"){
        radioLabel = tr("Qualcomm Z10/P9982 Radio:");
    }
    if (device == "8960omadm"){
        radioLabel = tr("Verizon Z10 Radio:");
    }
    if (device == "8960wtr" || device == "8960wtr_dac"){
        radioLabel = tr("Q10/Q5/P9983 Radio:");
    }
    if (device == "8960wtr5"){
        radioLabel = tr("Z30/Manitoba/Classic Radio:");
    }
    if (device == "8930wtr5"){
        radioLabel = tr("Z3/Kopi/Cafe Radio:");
    }
    if (device == "8974_sqw"){
        radioLabel = tr("Passport Radio:");
    }
    if (device == "8974"){
        radioLabel = tr("Aquila/Aquarius Radio:");
    }
}

void LinkGenerator::setDeltaOsLabel(QString type, QString os, QString initialos)
{
    if (type == "core"){
        deltaOsLabel = tr("Delta from ")  + initialos + tr(" to ") + os + ":";
    }
    if (type == "core_vzw"){
        deltaOsLabel = tr("Verizon delta from ") + initialos + tr(" to ") +  os + ":";
    }
}

void LinkGenerator::setDeltaRadioLabel(QString device, QString radio, QString initialradio)
{
    if (device == "winchester"){
        deltaRadioLabel = tr("OMAP Z10 radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
    if (device == "8960"){
        deltaRadioLabel = tr("Qualcomm Z10/P9982 radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
    if (device == "8960omadm"){
        deltaRadioLabel = tr("Verizon Z10 radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
    if (device == "8960wtr"){
        deltaRadioLabel = tr("Q10/Q5/P9983 radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
    if (device == "8960wtr5"){
        deltaRadioLabel = tr("Z30/Classic radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
    if (device == "8930wtr5"){
        deltaRadioLabel = tr("Z3 radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
    if (device == "8974_sqw"){
        deltaRadioLabel = tr("Passport radio delta from ") + initialradio + tr(" to ") + radio + ":";
    }
}

void LinkGenerator::forceOS(QString text){
    osLink = text;
}

void LinkGenerator::forceRadio(QString text){
    radioLink = text;
}

void LinkGenerator::forceDeltaOS(QString text){
    deltaOsLink = text;
}

void LinkGenerator::forceDeltaRadio(QString text){
    deltaRadioLink = text;
}

QString LinkGenerator::getOS(){
    return osLink;
}

QString LinkGenerator::getRadio(){
    return radioLink;
}

QString LinkGenerator::getDeltaOS(){
    return deltaOsLink;
}

QString LinkGenerator::getDeltaRadio(){
    return deltaRadioLink;
}

QString LinkGenerator::getOsLabel(){
    return osLabel;
}

QString LinkGenerator::getRadioLabel(){
    return radioLabel;
}

QString LinkGenerator::getDeltaOsLabel(){
    return deltaOsLabel;
}

QString LinkGenerator::getDeltaRadioLabel(){
    return deltaRadioLabel;
}

QString LinkGenerator::incrementRadio(QString input){
    if (input == "Error"){
        return input;
    }
    if (input == ""){
        return "Error";
    }
    QStringList splitarray = input.split(".");
    if (splitarray[3] == "") {
        return "Error";
    }
    else {
        QString newrad = QString::number(((splitarray[3]).toInt() + 1));
        splitarray[3] = newrad;
        return splitarray.join(".");
    }
}

LinkGenerator::~LinkGenerator()
{

}

