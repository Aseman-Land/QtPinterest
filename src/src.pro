TEMPLATE = subdirs
SUBDIRS = \
    pinterest \
    qml

qml.depends += pinterest
