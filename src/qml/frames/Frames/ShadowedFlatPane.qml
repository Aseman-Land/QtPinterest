import QtQuick 2.0
import QtGraphicalEffects 1.0
import Pinterest.Base 1.0

Item {
    id: item

    default property alias contentItem: scene.data
    property alias background: sceneRect.color
    property alias shadow: shdw.color
    property alias radius: sceneRect.radius

    property real padding: 16 * PinterestGlobals.density

    FastRectengleShadow {
        id: shdw
        anchors.fill: sceneMask
        verticalOffset: 12 * sceneMask.ratio
        radius: 60 * sceneMask.ratio
        cached: true
        color: "#133f6f"
        opacity: 0.3
    }

    Item {
        id: sceneMask
        anchors.fill: parent
        anchors.margins: 16 * sceneMask.ratio

        property real ratio: item.padding / 16

        Rectangle {
            id: sceneRect
            anchors.fill: parent
            radius: 5 * PinterestGlobals.density
        }
    }

    Item {
        id: scene
        anchors.fill: sceneMask
        anchors.margins: sceneRect.anchors.margins
    }
}
