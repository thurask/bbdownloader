/*Nomedia.cpp
-------------
Handles operations regarding .nomedia files.

--Thurask*/

#include "Nomedia.hpp"

Nomedia::Nomedia()
{

}

void Nomedia::setDir(QString directory)
{
dir = QDir(directory);
file.setFileName(dir.absoluteFilePath(".nomedia"));
}

bool Nomedia::checkNomedia()
{
    if (file.exists()){
        return true;
    }
    else {
        return false;
    }
}

void Nomedia::deleteNomedia()
{
    file.remove();
}

void Nomedia::writeNomedia()
{
    file.open(QIODevice::WriteOnly);
    file.close();
}

Nomedia::~Nomedia()
{

}

