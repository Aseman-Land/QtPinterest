#include "qpinterestitem.h"
#include "qpinterestglobals.h"
#include "qpinterestglobals_p.h"

class QPinterestItem::Private
{
public:
    qint32 layoutDirection;
};

QPinterestItem::QPinterestItem(QQuickItem *parent) :
    QQuickItem(parent)
{
    p = new Private;
    p->layoutDirection = -1;

    connect(QPinterestGlobals::core(), &QPinterestGlobalsCore::layoutDirectionChanged, this, [this](){
        if(p->layoutDirection == -1)
            Q_EMIT layoutDirectionChanged();
    });
}

qint32 QPinterestItem::layoutDirection() const
{
    if(p->layoutDirection == -1)
        return QPinterestGlobals::core()->layoutDirection();

    return p->layoutDirection;
}

void QPinterestItem::setLayoutDirection(qint32 layoutDirection)
{
    if(p->layoutDirection == layoutDirection)
        return;

    p->layoutDirection = layoutDirection;
    Q_EMIT layoutDirectionChanged();
}

QPinterestItem::~QPinterestItem()
{
    delete p;
}
