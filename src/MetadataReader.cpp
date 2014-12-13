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
    setRuntimeMetadata(QString(reply->readAll()));
    sender()->deleteLater();
}

void MetadataReader::readSimulatorMetadata()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    setSimulatorMetadata(QString(reply->readAll()));
    sender()->deleteLater();
}

QString MetadataReader::getRuntimeMetadata()
{
    return runtimeMetadata;
}

void MetadataReader::setRuntimeMetadata(QString runtime)
{
    runtimeMetadata = runtime;
}

QString MetadataReader::getSimulatorMetadata()
{
    return simulatorMetadata;
}

void MetadataReader::setSimulatorMetadata(QString simulator)
{
    simulatorMetadata = simulator;
}

MetadataReader::~MetadataReader()
{

}

