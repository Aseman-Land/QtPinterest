#ifndef QPINTERESTGLOBALS_P_H
#define QPINTERESTGLOBALS_P_H

#include <QObject>

#include "qtpinterest_global.h"

class LIBQT_PINTEREST_EXPORT QPinterestGlobalsCore : public QObject
{
    Q_OBJECT
    class Private;

public:
    QPinterestGlobalsCore(QObject *parent = Q_NULLPTR);
    virtual ~QPinterestGlobalsCore();

    qreal density() const;
    void setDensity(qreal density);

    qreal fontDensity() const;
    void setFontDensity(qreal fontDensity);

    qint32 layoutDirection() const;
    void setLayoutDirection(qint32 layoutDirection);

Q_SIGNALS:
    void densityChanged();
    void fontDensityChanged();
    void layoutDirectionChanged();

private:
    Private *p;
};

#endif // QPINTERESTGLOBALS_P_H
