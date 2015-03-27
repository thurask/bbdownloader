#ifndef METADATAREADER_HPP_
#define METADATAREADER_HPP_

#include <QtCore>
#include <QtNetwork>

/*!
 *  @class     MetadataReader
 *  @brief     MetadataReader class
 *  @details   Read Momentics simulator and runtime metadata lists from BlackBerry server
 *  @author    Thurask
 *  @date      2014-2015
 */
class MetadataReader: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString runtimeMetadata READ getRuntimeMetadata WRITE setRuntimeMetadata)
    Q_PROPERTY(QString simulatorMetadata READ getSimulatorMetadata WRITE setSimulatorMetadata)

public:
    MetadataReader();
    virtual ~MetadataReader();

public Q_SLOTS:
    Q_INVOKABLE
    void getMetadata();
    Q_INVOKABLE
    void readRuntimeMetadata();
    Q_INVOKABLE
    void readSimulatorMetadata();
    Q_INVOKABLE
    QString getRuntimeMetadata();
    Q_INVOKABLE
    void setRuntimeMetadata(QString runtime);
    Q_INVOKABLE
    QString getSimulatorMetadata();
    Q_INVOKABLE
    void setSimulatorMetadata(QString simulator);

private:
    QString runtimeMetadata;
    QString simulatorMetadata;
};

#endif /* METADATAREADER_HPP_ */
