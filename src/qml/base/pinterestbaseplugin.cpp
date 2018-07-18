#include "pinterestbaseplugin.h"

#include <QPinterestGlobals>
#include <QPinterestItem>
#include <QPinterestProxyComponent>
#include <QQmlEngine>

static QObject *pinterest_globals_singleton(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    static QPinterestGlobals *singleton = new QPinterestGlobals(engine);
    return singleton;
}

void PinterestBasePlugin::registerTypes(const char *uri)
{
    qmlRegisterType<QPinterestItem>(uri, 1, 0, "PinterestItem");
    qmlRegisterType<QPinterestProxyComponent>(uri, 1, 0, "ProxyComponent");
    qmlRegisterSingletonType<QPinterestGlobals>(uri, 1, 0, "PinterestGlobals", pinterest_globals_singleton);
}

void PinterestBasePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
