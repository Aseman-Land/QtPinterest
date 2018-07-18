#include "qpinterestproxycomponent.h"

#include <QPointer>
#include <QQuickItem>
#include <QDebug>

class QPinterestProxyComponent::Private
{
public:
    QPointer<QQmlComponent> source;
    QPointer<QObject> object;
};

QPinterestProxyComponent::QPinterestProxyComponent(QObject *parent) :
    QObject(parent)
{
    p = new Private;
}

QQmlComponent *QPinterestProxyComponent::source() const
{
    return p->source;
}

void QPinterestProxyComponent::setSource(QQmlComponent *source)
{
    if(p->source == source)
        return;

    p->source = source;
    create();
    Q_EMIT sourceChanged();
}

QObject *QPinterestProxyComponent::object() const
{
    return p->object;
}

void QPinterestProxyComponent::setObject(QObject *object)
{
    if(p->object == object)
        return;
    if(p->object)
        p->object->deleteLater();

    p->object = object;
    Q_EMIT objectChanged();
}

void QPinterestProxyComponent::create()
{
    if(!p->source)
    {
        setObject(Q_NULLPTR);
        return;
    }

    QObject *parent = QPinterestProxyComponent::parent();

    QQmlContext *context = qmlContext(this);
    QObject *object = p->source->create(context);
    if(object)
    {
        object->setParent(parent);

        QQuickItem *parentItem = qobject_cast<QQuickItem*>(parent);
        QQuickItem *objectItem = qobject_cast<QQuickItem*>(object);
        if(parentItem && objectItem)
            objectItem->setParentItem(parentItem);
    }

    setObject(object);
}

QPinterestProxyComponent::~QPinterestProxyComponent()
{
    delete p;
}
