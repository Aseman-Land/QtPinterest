import QtQuick 2.0
import Pinterest.Base 1.0
import Pinterest.Frames 1.0 as Frames

SuperDynamicHeader {
    id: superHeader
    
    property color masterHeaderColor: "#0d80ec"

    property color subHeaderColor: "#ffffff"
    property real subHeaderRadius: 5*PinterestGlobals.density

    property alias shadowColor: shadowPane.shadow

    property Item masterItem
    property Item subItem

    onMasterItemChanged: {
        if(!masterItem) return

        masterItem.parent = mainScene
        masterItem.anchors.fill = mainScene
    }

    onSubItemChanged: {
        if(!subItem) return

        subItem.parent = subScene
        subItem.anchors.fill = subScene
    }

    masterHeaderHeight: masterHeaderMinimumHeight + 80*PinterestGlobals.density
    masterHeaderMinimumHeight: 60*PinterestGlobals.density
    masterHeader: Item {
        Rectangle {
            id: mainBackground
            anchors.fill: parent
            color: masterHeaderColor
            opacity: 1 - (height - superHeader.masterHeaderMinimumHeight) / (superHeader.masterHeaderHeight - superHeader.masterHeaderMinimumHeight)
        }

        Item {
            id: mainScene
            anchors.fill: parent
        }
    }
    subHeaderHeight: 80*PinterestGlobals.density
    subHeaderMinimumHeight: 30*PinterestGlobals.density
    subHeader: Item {
        Frames.ShadowedFlatPane {
            id: shadowPane
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width + mainBackground.opacity * 40*PinterestGlobals.density
            height: 90*PinterestGlobals.density
            anchors.bottom: parent.bottom
            anchors.bottomMargin: subHeaderMinimumHeight - 15*PinterestGlobals.density
            radius: subHeaderRadius * (1-mainBackground.opacity)
            background: subHeaderColor

            Item {
                id: subScene
                anchors.fill: parent
                anchors.topMargin: mainBackground.opacity * (subHeaderMinimumHeight - 23*PinterestGlobals.density)
            }
        }
    }
}
