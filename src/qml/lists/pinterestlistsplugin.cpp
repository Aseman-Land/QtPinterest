#include "pinterestlistsplugin.h"

#include <QPinterestTools>

#ifdef PINTEREST_STATIC_BUILD
bool PinterestListsPlugin::static_types_registered = PinterestListsPlugin::registerStaticTypes("Pinterest.Lists");
#endif

bool PinterestListsPlugin::registerStaticTypes(const char *uri)
{
#ifdef PINTEREST_STATIC_BUILD
    if(static_types_registered)
        return true;
#endif

    Q_INIT_RESOURCE(qmake_pinterestlists);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Lists"), uri);
    return true;
}

void PinterestListsPlugin::registerTypes(const char *uri)
{
    PinterestListsPlugin::registerStaticTypes(uri);
}

void PinterestListsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
