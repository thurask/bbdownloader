/*
 * Nomedia.cpp
 *
 *  Created on: Sep 25, 2014
 *      Author: Thurask
 */

#include "Nomedia.hpp"

Nomedia::Nomedia()
{
//constructor
}

void Nomedia::setDir(QString directory)
{
dir = QDir(directory); //set our working directory from the input (FilePicker)
file.setFileName(dir.absoluteFilePath(".nomedia")); //set the filename to work with as .nomedia within the above directory
}

bool Nomedia::checkNomedia()
{
    if (file.exists()){ //file.exists() is a boolean, hence this function is, too
        return true;
    }
    else {
        return false;
    }
}

void Nomedia::deleteNomedia()
{
    file.remove(); //remove() deletes the file
}

void Nomedia::writeNomedia()
{
    file.open(QIODevice::WriteOnly); //open() creates it, the QIODevice argument specifies read, write or read/write
    file.close(); //close() closes it; don't need to write anything for a .nomedia file, since they're blank
}

Nomedia::~Nomedia()
{
//destructor
}

