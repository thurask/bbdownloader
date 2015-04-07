#include "Nomedia.hpp"
#include <QtCore>

Nomedia::Nomedia()
{

}

void Nomedia::setDir(const QString& directory)
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
    fa.logEvent("NOMEDIA_WRITTEN", false);
}

Nomedia::~Nomedia()
{

}

