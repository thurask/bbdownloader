/*LinkGenerator.cpp
--------------------
Handles link generation and related operations.

--Thurask*/

#include "LinkGenerator.hpp"
#include <QtCore>

LinkGenerator::LinkGenerator()
{

}

QString LinkGenerator::incrementRadio(QString input){
    QRegExp rx("(\\d{0,4}\\.)(\\d{0,4}\\.)(\\d{0,4}\\.)(\\d{0,4})");
    if (input.contains(rx) == true){
        QStringList splitarray = input.split(".");
        QString newrad = QString::number(((splitarray[3]).toInt() + 1));
        splitarray[3] = newrad;
        return splitarray.join(".");
    }
    else {
        return tr("Error");
    }
}

LinkGenerator::~LinkGenerator()
{

}

