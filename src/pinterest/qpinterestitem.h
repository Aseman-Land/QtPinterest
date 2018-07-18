#ifndef QPINTERESTITEM_H
#define QPINTERESTITEM_H

#include <QQuickItem>

#include "qtpinterest_global.h"

class LIBQT_PINTEREST_EXPORT QPinterestItem : public QQuickItem
{
    Q_OBJECT
    class Private;
    Q_PROPERTY(qint32 layoutDirection READ layoutDirection WRITE setLayoutDirection NOTIFY layoutDirectionChanged)

public:
    QPinterestItem(QQuickItem *parent = Q_NULLPTR);
    virtual ~QPinterestItem();

    qint32 layoutDirection() const;
    void setLayoutDirection(qint32 layoutDirection);

Q_SIGNALS:
    void layoutDirectionChanged();

private:
    Private *p;
};

#endif // QPINTERESTITEM_H
