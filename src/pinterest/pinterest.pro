load(qt_build_config)

INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

TARGET = QtPinterest
QT = core gui qml quick network

MODULE = pinterest

load(qt_module)

DEFINES += LIBQT_PINTEREST_LIBRARY

HEADERS += \
    $$PWD/qpinterestitem.h \
    $$PWD/qtpinterest_global.h \
    $$PWD/qpinteresttools.h \
    $$PWD/qpinterestglobals.h \
    $$PWD/qpinterestglobals_p.h \
    $$PWD/qpinterestproxycomponent.h

SOURCES += \
    $$PWD/qpinterestitem.cpp \
    $$PWD/qpinteresttools.cpp \
    $$PWD/qpinterestglobals.cpp \
    $$PWD/qpinterestproxycomponent.cpp
