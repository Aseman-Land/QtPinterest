#include "qpinteresttools.h"

#include <QtQml>
#include <QStringList>
#include <QDir>
#include <QUrl>

void QPinterestTools::registerQmls(const QString &filesLocation, const char *uri)
{
    QFile file(filesLocation + QStringLiteral("/qmldir"));
    if(file.open(QFile::ReadOnly))
    {
        QStringList lines = QString::fromUtf8(file.readAll()).split(QStringLiteral("\n"), QString::SkipEmptyParts);
        file.close();

        for(const QString &l: lines)
        {
            QStringList parts = l.split(QStringLiteral(" "), QString::SkipEmptyParts);
            bool singleton = false;
            if(parts.count() && parts.first() == QStringLiteral("singleton"))
                singleton = parts.takeFirst().count();
            if(parts.length() != 3)
                continue;

            QStringList version = parts.at(1).split(QStringLiteral("."), QString::SkipEmptyParts);
            if(version.count() != 2)
                continue;

            if(singleton)
                qmlRegisterSingletonType(QUrl(QStringLiteral("qrc") + filesLocation + QStringLiteral("/") + parts.at(2)),
                                         uri, version.at(0).toInt(), version.at(1).toInt(), parts.at(0).toUtf8());
            else
                qmlRegisterType(QUrl(QStringLiteral("qrc") + filesLocation + QStringLiteral("/") + parts.at(2)),
                                uri, version.at(0).toInt(), version.at(1).toInt(), parts.at(0).toUtf8());
        }
    }
}
