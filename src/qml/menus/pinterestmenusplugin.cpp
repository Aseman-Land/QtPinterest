#include "pinterestmenusplugin.h"

#include <QPinterestTools>

void PinterestMenusPlugin::registerTypes(const char *uri)
{
    Q_INIT_RESOURCE(qmake_pinterestmenus);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Menus"), uri);
}

void PinterestMenusPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
