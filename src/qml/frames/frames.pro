TARGET  = pinterestframes
TARGETPATH = Pinterest/Frames
IMPORT_VERSION = 1.0

QT += core gui network quick qml pinterest

HEADERS += \
    $$PWD/pinterestframesplugin.h

SOURCES += \
    $$PWD/pinterestframesplugin.cpp

static: DEFINES += PINTEREST_STATIC_BUILD

PINTEREST_QML_FILES += $$files($$PWD/Frames/*, true)

INCLUDED_RESOURCE_FILES += \
    $$PINTEREST_QML_FILES

pinterestframes.files = $$INCLUDED_RESOURCE_FILES
pinterestframes.prefix = /Pinterest/
RESOURCES += pinterestframes

load(qml_plugin)
