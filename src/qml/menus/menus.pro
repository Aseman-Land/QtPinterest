TARGET  = pinterestmenus
TARGETPATH = Pinterest/Menus
IMPORT_VERSION = 1.0

QT += core gui network quick qml pinterest

HEADERS += \
    $$PWD/pinterestmenusplugin.h

SOURCES += \
    $$PWD/pinterestmenusplugin.cpp

static: DEFINES += PINTEREST_STATIC_BUILD

PINTEREST_QML_FILES += $$files($$PWD/Menus/*, true)

INCLUDED_RESOURCE_FILES += \
    $$PINTEREST_QML_FILES

pinterestmenus.files = $$INCLUDED_RESOURCE_FILES
pinterestmenus.prefix = /Pinterest/
RESOURCES += pinterestmenus

load(qml_plugin)
