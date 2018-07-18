#ifndef QPINTERESTGLOBALS_H
#define QPINTERESTGLOBALS_H

#include <QObject>

#include "qtpinterest_global.h"

class LIBQT_PINTEREST_EXPORT QPinterestGlobals : public QObject
{
    Q_OBJECT
    class Private;

    Q_PROPERTY(qreal density READ density WRITE setDensity NOTIFY densityChanged)
    Q_PROPERTY(qreal fontDensity READ fontDensity WRITE setFontDensity NOTIFY fontDensityChanged)
    Q_PROPERTY(qint32 layoutDirection READ layoutDirection WRITE setLayoutDirection NOTIFY layoutDirectionChanged)

public:
    QPinterestGlobals(QObject *parent = Q_NULLPTR);
    virtual ~QPinterestGlobals();

    qreal density() const;
    void setDensity(qreal density);

    qreal fontDensity() const;
    void setFontDensity(qreal fontDensity);

    qint32 layoutDirection() const;
    void setLayoutDirection(qint32 layoutDirection);

    static class QPinterestGlobalsCore *core();

Q_SIGNALS:
    void densityChanged();
    void fontDensityChanged();
    void layoutDirectionChanged();

private:
    Private *p;
};

#endif // QPINTERESTGLOBALS_H
