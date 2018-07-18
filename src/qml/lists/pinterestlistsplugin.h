#ifndef PINTERESTQMLPLUGIN_H
#define PINTERESTQMLPLUGIN_H

#include <QQmlExtensionPlugin>

class PinterestListsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *engine, const char *uri);
};

#endif // PINTERESTQMLPLUGIN_H
