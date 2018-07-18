#include "qpinterestglobals.h"
#include "qpinterestglobals_p.h"

class QPinterestGlobalsCore::Private
{
public:
    qreal density;
    qreal fontDensity;
    qint32 layoutDirection;
};

QPinterestGlobalsCore::QPinterestGlobalsCore(QObject *parent) :
    QObject(parent)
{
    p = new Private;
    p->density = 1;
    p->fontDensity = 1;
    p->layoutDirection = Qt::LayoutDirectionAuto;
}

qreal QPinterestGlobalsCore::density() const
{
    return p->density;
}

void QPinterestGlobalsCore::setDensity(qreal density)
{
    if(p->density == density)
        return;

    p->density = density;
    Q_EMIT densityChanged();
}

qreal QPinterestGlobalsCore::fontDensity() const
{
    return p->fontDensity;
}

void QPinterestGlobalsCore::setFontDensity(qreal fontDensity)
{
    if(p->fontDensity == fontDensity)
        return;

    p->fontDensity = fontDensity;
    Q_EMIT fontDensityChanged();
}

qint32 QPinterestGlobalsCore::layoutDirection() const
{
    return p->layoutDirection;
}

void QPinterestGlobalsCore::setLayoutDirection(qint32 layoutDirection)
{
    if(p->layoutDirection == layoutDirection)
        return;

    p->layoutDirection = layoutDirection;
    Q_EMIT layoutDirectionChanged();
}

QPinterestGlobalsCore::~QPinterestGlobalsCore()
{
    delete p;
}



class QPinterestGlobals::Private
{
public:
    static QPinterestGlobalsCore *core;
};

QPinterestGlobalsCore *QPinterestGlobals::Private::core = Q_NULLPTR;

QPinterestGlobals::QPinterestGlobals(QObject *parent) :
    QObject(parent)
{
    core();
    connect(Private::core, &QPinterestGlobalsCore::densityChanged, this, &QPinterestGlobals::densityChanged);
    connect(Private::core, &QPinterestGlobalsCore::fontDensityChanged, this, &QPinterestGlobals::fontDensityChanged);
    connect(Private::core, &QPinterestGlobalsCore::layoutDirectionChanged, this, &QPinterestGlobals::layoutDirectionChanged);
}

QPinterestGlobalsCore *QPinterestGlobals::core()
{
    if(!Private::core)
        Private::core = new QPinterestGlobalsCore();

    return Private::core;
}

qreal QPinterestGlobals::density() const
{
    return Private::core->density();
}

void QPinterestGlobals::setDensity(qreal density)
{
    Private::core->setDensity(density);
}

qreal QPinterestGlobals::fontDensity() const
{
    return Private::core->fontDensity();
}

void QPinterestGlobals::setFontDensity(qreal fontDensity)
{
    Private::core->setFontDensity(fontDensity);
}

qint32 QPinterestGlobals::layoutDirection() const
{
    return Private::core->layoutDirection();
}

void QPinterestGlobals::setLayoutDirection(qint32 layoutDirection)
{
    Private::core->setLayoutDirection(layoutDirection);
}

QPinterestGlobals::~QPinterestGlobals()
{
}
