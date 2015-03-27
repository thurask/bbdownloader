#include "MetadataReader.hpp"
#include <QtCore>

MetadataReader::MetadataReader()
{

}

void MetadataReader::getMetadata()
{
    QUrl runtimeurl(
            "http://downloads.blackberry.com/upr/developers/update/bbndk/runtime/runtime_metadata");
    QUrl simulatorurl(
            "http://downloads.blackberry.com/upr/developers/update/bbndk/simulator/simulator_metadata");
    QNetworkAccessManager *nam = new QNetworkAccessManager(this);
    QNetworkReply *runtimereply = nam->get(QNetworkRequest(runtimeurl));
    connect(runtimereply, SIGNAL(finished()), this, SLOT(readRuntimeMetadata()));
    QNetworkReply *simulatorreply = nam->get(QNetworkRequest(simulatorurl));
    connect(simulatorreply, SIGNAL(finished()), this, SLOT(readSimulatorMetadata()));
}

void MetadataReader::readRuntimeMetadata()
{
    QStringList metversion;
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QString rawmet = reply->readAll();
    if (!(rawmet.simplified().isEmpty())) {
        QString oldmetadata("10.1.0.1020\n"
                "10.0.10.822\n"
                "10.0.10.738\n"
                "10.0.10.690\n"
                "10.0.10.684\n"
                "10.0.10.672\n"
                "10.0.10.648\n"
                "10.0.10.261\n"
                "10.0.9.2743\n"
                "10.0.9.2709\n"
                "10.0.9.2372\n"
                "10.1.0.1483\n"
                "10.1.0.1627\n"
                "10.1.0.1720\n"
                "10.1.0.1910\n"
                "10.1.0.1916\n"
                "10.1.0.2025\n"
                "10.1.0.2062\n"
                "10.1.0.2038\n"
                "10.1.0.2050\n"
                "10.1.0.2074\n"
                "10.1.0.2121\n"
                "10.1.0.2151\n"
                "10.1.0.2342\n"
                "10.1.0.2354\n"
                "10.1.0.2420\n"
                "10.1.0.4537\n"
                "10.1.0.4633\n"
                "10.1.0.4651\n"
                "10.1.0.4699\n"
                "10.1.0.4780\n"
                "10.1.0.4828\n"
                "10.2.0.1155\n");
        QStringList oldsplit = oldmetadata.split("\n");
        for (int i = 0; i < oldsplit.count() - 1; i++) {
            metversion.append(oldsplit[i]);
        }
    }
    QStringList linemet = rawmet.split("\n");
    for (int i = 0; i < linemet.count() - 1; i++) {
        metversion.append((linemet[i].split(",")[1]));
    }
    metversion.sort();
    setRuntimeMetadata(metversion.join("\n"));
    sender()->deleteLater();
}

void MetadataReader::readSimulatorMetadata()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QString rawsim = reply->readAll();
    QStringList linesim = rawsim.split("\n");
    QStringList simversion;
    for (int i = 0; i < linesim.count() - 1; i++) {
        simversion.append((linesim[i].split(",")[1]));
    }
    simversion.sort();
    setSimulatorMetadata(simversion.join("\n"));
    sender()->deleteLater();
}

QString MetadataReader::getRuntimeMetadata()
{
    return runtimeMetadata;
}

void MetadataReader::setRuntimeMetadata(QString runtime)
{
    if (runtime.startsWith('\n')) {
        runtime.remove(0, 1);
    }
    if (runtime.endsWith('\n')) {
        runtime.chop(1);
    }
    if (runtime.startsWith('\n') && runtime.endsWith('\n')) {
        runtime.remove(0, 1);
        runtime.chop(1);
    }
    runtimeMetadata = runtime;
}

QString MetadataReader::getSimulatorMetadata()
{
    return simulatorMetadata;
}

void MetadataReader::setSimulatorMetadata(QString simulator)
{
    if (simulator.startsWith('\n')) {
        simulator.remove(0, 1);
    }
    if (simulator.endsWith('\n')) {
        simulator.chop(1);
    }
    if (simulator.startsWith('\n') && simulator.endsWith('\n')) {
        simulator.remove(0, 1);
        simulator.chop(1);
    }
    simulatorMetadata = simulator;
}

MetadataReader::~MetadataReader()
{

}

