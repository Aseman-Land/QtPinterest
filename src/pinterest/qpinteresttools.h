#ifndef QPINTERESTTOOLS_H
#define QPINTERESTTOOLS_H

#include <QString>

#include "qtpinterest_global.h"

class LIBQT_PINTEREST_EXPORT QPinterestTools
{
public:
    static void registerQmls(const QString &filesLocation, const char *uri);
};

#endif // QPINTERESTTOOLS_H
