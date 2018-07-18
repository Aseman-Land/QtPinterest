#ifndef QT_PINTEREST_GLOBAL_H
#define QT_PINTEREST_GLOBAL_H

#include <QtCore/qglobal.h>

#ifndef QT_STATIC
#if defined(LIBQT_PINTEREST_LIBRARY)
#  define LIBQT_PINTEREST_EXPORT Q_DECL_EXPORT
#else
#  define LIBQT_PINTEREST_EXPORT Q_DECL_IMPORT
#endif
#else
#define LIBQT_PINTEREST_EXPORT
#endif

#endif // QT_PINTEREST_GLOBAL_H
