#include "pinterestbaseplugin.h"

#include <QPinterestGlobals>
#include <QPinterestItem>
#include <QPinterestProxyComponent>
#include <QPinterestTools>
#include <QQmlEngine>

#ifdef PINTEREST_STATIC_BUILD
bool PinterestBasePlugin::static_types_registered = PinterestBasePlugin::registerStaticTypes("Pinterest.Base");
#endif

static QObject *pinterest_globals_singleton(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    static QPinterestGlobals *singleton = new QPinterestGlobals(engine);
    return singleton;
}

bool PinterestBasePlugin::registerStaticTypes(const char *uri)
{
#ifdef PINTEREST_STATIC_BUILD
    if(static_types_registered)
        return true;
#endif
    Q_INIT_RESOURCE(qmake_pinterestbase);

    qmlRegisterType<QPinterestItem>(uri, 1, 0, "PinterestItem");
    qmlRegisterType<QPinterestProxyComponent>(uri, 1, 0, "ProxyComponent");
    qmlRegisterSingletonType<QPinterestGlobals>(uri, 1, 0, "PinterestGlobals", pinterest_globals_singleton);
    QPinterestTools::registerQmls(QStringLiteral(":/Pinterest/Base"), uri);
    return true;
}

void PinterestBasePlugin::registerTypes(const char *uri)
{
    PinterestBasePlugin::registerStaticTypes(uri);
}

void PinterestBasePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
