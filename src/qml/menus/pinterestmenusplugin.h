#ifndef PINTERESTMENUSPLUGIN_H
#define PINTERESTMENUSPLUGIN_H

#include <QQmlExtensionPlugin>

class PinterestMenusPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *engine, const char *uri);
};

#endif // PINTERESTMENUSPLUGIN_H
