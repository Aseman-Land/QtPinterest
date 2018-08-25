import QtQuick 2.0
import Pinterest.Base 1.0

Item {
    id: headItem
    height: subHeaderHeight + masterHeaderHeight
    z: 100

    readonly property ListView view: parent && parent.parent? parent.parent : null

    property Item masterHeader
    property real masterHeaderHeight: 100 * PinterestGlobals.density
    property real masterHeaderMinimumHeight: 60 * PinterestGlobals.density

    property Item subHeader
    property real subHeaderHeight: 50 * PinterestGlobals.density
    property real subHeaderMinimumHeight: 0 * PinterestGlobals.density

    onMasterHeaderChanged: {
        if(!masterHeader) return

        masterHeader.parent = mainHead
        masterHeader.anchors.fill = mainHead
    }

    onSubHeaderChanged: {
        if(!subHeader) return

        subHeader.parent = subHead
        subHeader.anchors.fill = subHead
    }

    PointMapListener {
        id: listener
        source: headItem
        dest: view

        property real itemY: result.y
        property real itemX: result.x

        onItemYChanged: {
            var delta = (itemY - lastItemY)
            var res = mediumItemY + delta
            if(itemY + masterHeaderHeight > masterHeaderMinimumHeight) {
                res = itemY + masterHeaderHeight
                if(res > masterHeaderHeight)
                    res = masterHeaderHeight
            } else {
                if(res < -subHeaderHeight)
                    res = -subHeaderHeight
                else
                if(res > masterHeaderMinimumHeight)
                    res = masterHeaderMinimumHeight
            }

            mediumItemY = res
            lastItemY = itemY
        }

        property real lastItemY: 0
        property real mediumItemY
    }

    Item {
        id: mainHead
        parent: view
        height: {
            var res = listener.itemY
            if(res > 0)
                res = 0
            if(res < -masterHeaderHeight + masterHeaderMinimumHeight)
                res = -masterHeaderHeight + masterHeaderMinimumHeight
            return masterHeaderHeight + res
        }
        x: listener.itemX
        width: headItem.width
    }

    Item {
        id: subHead
        parent: view
        y: mainHead.height
        x: listener.itemX
        width: headItem.width
        height: {
            var res = subHeaderHeight + listener.mediumItemY - mainHead.height
            if(res < subHeaderMinimumHeight)
                res = subHeaderMinimumHeight
            return res
        }
    }
}
