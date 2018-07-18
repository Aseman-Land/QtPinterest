#ifndef QPINTERESTPROXYCOMPONENT_H
#define QPINTERESTPROXYCOMPONENT_H

#include <QObject>
#include <QQmlComponent>

#include "qtpinterest_global.h"

class LIBQT_PINTEREST_EXPORT QPinterestProxyComponent : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlComponent* source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QObject* object READ object NOTIFY objectChanged)

    class Private;

public:
    QPinterestProxyComponent(QObject *parent = Q_NULLPTR);
    virtual ~QPinterestProxyComponent();

    QQmlComponent *source() const;
    void setSource(QQmlComponent *component);

    QObject *object() const;

Q_SIGNALS:
    void sourceChanged();
    void objectChanged();

private:
    void create();
    void setObject(QObject *object);

private:
    Private *p;
};

#endif // QPINTERESTPROXYCOMPONENT_H
