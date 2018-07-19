TARGET  = pinterestbase
TARGETPATH = Pinterest/Base
IMPORT_VERSION = 1.0

QT += core gui network quick qml pinterest

HEADERS += \
    $$PWD/pinterestbaseplugin.h

SOURCES += \
    $$PWD/pinterestbaseplugin.cpp

static: DEFINES += PINTEREST_STATIC_BUILD

PINTEREST_QML_FILES += $$files($$PWD/Base/*, true)

INCLUDED_RESOURCE_FILES += \
    $$PINTEREST_QML_FILES

pinterestbase.files = $$INCLUDED_RESOURCE_FILES
pinterestbase.prefix = /Pinterest/
RESOURCES += pinterestbase

load(qml_plugin)
