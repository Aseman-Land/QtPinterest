#include "pinterestframesplugin.h"

#include <QPinterestTools>

void PinterestFramesPlugin::registerTypes(const char *uri)
{
    Q_INIT_RESOURCE(qmake_pinterestframes);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Frames"), uri);
}

void PinterestFramesPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
