#ifndef PINTERESTFRAMESPLUGIN_H
#define PINTERESTFRAMESPLUGIN_H

#include <QQmlExtensionPlugin>

class PinterestFramesPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    static bool registerStaticTypes(const char *uri);

    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *engine, const char *uri);

private:
#ifdef PINTEREST_STATIC_BUILD
    static bool static_types_registered;
#endif
};

#endif // PINTERESTFRAMESPLUGIN_H
