/*
 * MetadataReader.cpp
 *
 *  Created on: Dec 12, 2014
 *      Author: thura_000
 */

#include "MetadataReader.hpp"

MetadataReader::MetadataReader()
{

}

void MetadataReader::getMetadata()
{
    QUrl runtimeurl("http://downloads.blackberry.com/upr/developers/update/bbndk/runtime/runtime_metadata");
    QUrl simulatorurl("http://downloads.blackberry.com/upr/developers/update/bbndk/simulator/simulator_metadata");
    QNetworkAccessManager *nam = new QNetworkAccessManager(this);
    QNetworkReply *runtimereply = nam->get(QNetworkRequest(runtimeurl));
    connect(runtimereply, SIGNAL(finished()), this, SLOT(readRuntimeMetadata()));
    QNetworkReply *simulatorreply = nam->get(QNetworkRequest(simulatorurl));
    connect(simulatorreply, SIGNAL(finished()), this, SLOT(readSimulatorMetadata()));
}

void MetadataReader::readRuntimeMetadata()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QString rawmet = reply->readAll();
    QStringList linemet = rawmet.split("\n");
    QStringList metversion;
    for (int i = 0; i < linemet.count() - 1; i++) {
        metversion.append((linemet[i].split(",")[1]));
    }
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
    setSimulatorMetadata(simversion.join("\n"));
    sender()->deleteLater();
}

QString MetadataReader::getRuntimeMetadata()
{
    return runtimeMetadata;
}

void MetadataReader::setRuntimeMetadata(QString runtime)
{
    if (runtime.startsWith('\n')){
        runtime.remove(0,1);
    }
    if (runtime.endsWith('\n')){
        runtime.chop(1);
    }
    if (runtime.startsWith('\n') && runtime.endsWith('\n')){
        runtime.remove(0,1);
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
    if (simulator.startsWith('\n')){
        simulator.remove(0, 1);
    }
    if (simulator.endsWith('\n')){
        simulator.chop(1);
    }
    if (simulator.startsWith('\n') && simulator.endsWith('\n')){
        simulator.remove(0,1);
        simulator.chop(1);
    }
    simulatorMetadata = simulator;
}

MetadataReader::~MetadataReader()
{

}

