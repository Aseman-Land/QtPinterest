TARGET  = pinterestbase
TARGETPATH = Pinterest/Base
IMPORT_VERSION = 1.0

QT += core gui network quick qml pinterest

HEADERS += \
    $$PWD/pinterestbaseplugin.h

SOURCES += \
    $$PWD/pinterestbaseplugin.cpp

static: DEFINES += PINTEREST_STATIC_BUILD
load(qml_plugin)
