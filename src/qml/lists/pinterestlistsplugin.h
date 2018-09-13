#ifndef PINTERESTLISTSPLUGIN_H
#define PINTERESTLISTSPLUGIN_H

#include <QQmlExtensionPlugin>

class PinterestListsPlugin : public QQmlExtensionPlugin
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

#endif // PINTERESTLISTSPLUGIN_H
