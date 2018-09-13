#include "pinterestmenusplugin.h"

#include <QPinterestTools>

#ifdef PINTEREST_STATIC_BUILD
bool PinterestMenusPlugin::static_types_registered = PinterestMenusPlugin::registerStaticTypes("Pinterest.Menus");
#endif

bool PinterestMenusPlugin::registerStaticTypes(const char *uri)
{
#ifdef PINTEREST_STATIC_BUILD
    if(static_types_registered)
        return true;
#endif

    Q_INIT_RESOURCE(qmake_pinterestmenus);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Menus"), uri);
    return true;
}

void PinterestMenusPlugin::registerTypes(const char *uri)
{
    PinterestMenusPlugin::registerStaticTypes(uri);
}

void PinterestMenusPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
