#include "pinterestlistsplugin.h"

#include <QPinterestTools>

void PinterestListsPlugin::registerTypes(const char *uri)
{
    Q_INIT_RESOURCE(qmake_pinterestlists);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Lists"), uri);
}

void PinterestListsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
