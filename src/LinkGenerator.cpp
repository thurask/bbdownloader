/*LinkGenerator.cpp
--------------------
Handles link generation (TODO) and related operations.

--Thurask*/

#include "LinkGenerator.hpp"
#include <QtCore>

LinkGenerator::LinkGenerator()
{

}

QString LinkGenerator::incrementRadio(QString input){
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

