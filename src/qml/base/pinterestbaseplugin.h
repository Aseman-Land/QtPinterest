#ifndef PINTERESTBASEPLUGIN_H
#define PINTERESTBASEPLUGIN_H

#include <QQmlExtensionPlugin>

class PinterestBasePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *engine, const char *uri);
};

#endif // PINTERESTBASEPLUGIN_H
