#include "pinterestframesplugin.h"

#include <QPinterestTools>

#ifdef PINTEREST_STATIC_BUILD
bool PinterestFramesPlugin::static_types_registered = PinterestFramesPlugin::registerStaticTypes("Pinterest.Frames");
#endif

bool PinterestFramesPlugin::registerStaticTypes(const char *uri)
{
#ifdef PINTEREST_STATIC_BUILD
    if(static_types_registered)
        return true;
#endif

    Q_INIT_RESOURCE(qmake_pinterestframes);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Frames"), uri);
    return true;
}

void PinterestFramesPlugin::registerTypes(const char *uri)
{
    PinterestFramesPlugin::registerStaticTypes(uri);
}

void PinterestFramesPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
