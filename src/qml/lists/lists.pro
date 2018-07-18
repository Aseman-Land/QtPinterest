TARGET  = pinterestlists
TARGETPATH = Pinterest/Lists
IMPORT_VERSION = 1.0

QT += core gui network quick qml pinterest

HEADERS += \
    $$PWD/pinterestlistsplugin.h

SOURCES += \
    $$PWD/pinterestlistsplugin.cpp

static: DEFINES += PINTEREST_STATIC_BUILD

PINTEREST_QML_FILES += $$files($$PWD/Lists/*, true)

INCLUDED_RESOURCE_FILES += \
    $$PINTEREST_QML_FILES

pinterestlists.files = $$INCLUDED_RESOURCE_FILES
pinterestlists.prefix = /Pinterest/
RESOURCES += pinterestlists

load(qml_plugin)
