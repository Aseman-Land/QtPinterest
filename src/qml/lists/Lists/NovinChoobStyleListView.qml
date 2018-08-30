import QtQuick 2.7
import Pinterest.Base 1.0 as Base
import Pinterest.Frames 1.0 as Frames
import Pinterest.Lists 1.0 as Lists
import QtGraphicalEffects 1.0

Base.PinterestItem {
    id: nvcListView

    property Component masterItem
    property Component subItem
    property Component panelDelegate

    property real masterHeaderMinimumHeight: 60 * Base.PinterestGlobals.density
    property real masterHeaderHeight: 240 * Base.PinterestGlobals.density

    property alias floatingButton: floatingBtn
    property alias floatingButtonOpened: floatingBtn.opened

    property alias view: listv
    property alias maximumFlickVelocity: listv.maximumFlickVelocity
    property alias model: listv.model
    property Component delegate
    
    property color backgroundColor: "#fff"
    property color foregroundColor: "#333"

    readonly property real ratio: {
        var header = listv.headerItem
        if(!header)
            return 0

        var res = (header.masterHeader.height - header.masterHeaderMinimumHeight) / (header.masterHeaderHeight - header.masterHeaderMinimumHeight)
        if(res < 0.0001)
            res = 0
        if(res > 0.9999)
            res = 1
        return res;
    }

    readonly property real subRatio: {
        var header = listv.headerItem
        if(!header)
            return 0

        var res = (header.subHeader.height - header.subHeaderMinimumHeight) / (header.subHeaderHeight - header.subHeaderMinimumHeight)
        if(res < 0.0001)
            res = 0
        if(res > 0.9999)
            res = 1
        return res;
    }

    function floatingButtonToggle() {
        floatingBtn.toggle()
    }

    Rectangle {
        anchors.fill: parent
        color: nvcListView.backgroundColor
    }

    Rectangle {
        id: llistFrame
        anchors.fill: parent
        anchors.margins: -200 * Base.PinterestGlobals.density
        transform: Scale {
            xScale: llistFrame.scaleNumber
            yScale: llistFrame.scaleNumber
            origin.x: llistFrame.width/2
            origin.y: llist.y + nvcListView.masterHeaderMinimumHeight
        }
        color: nvcListView.backgroundColor

        property real scaleNumber: {
            var ratio = floatingBtn.ratio*2 - 1
            if(ratio < 0)
                ratio = 0
            return 1 - ratio/4
        }

        Lists.LazyList {
            id: llist
            anchors.fill: parent
            anchors.margins: - llistFrame.anchors.margins

            ListView {
                id: listv
                anchors.fill: parent
                header: Lists.RollerDoubleHeader {
                    id: superHeader
                    width: llist.width
                    masterHeaderMinimumHeight: nvcListView.masterHeaderMinimumHeight
                    masterHeaderHeight: nvcListView.masterHeaderHeight
                    masterHeaderColor: "transparent"
                    masterHeader.opacity: subHeader.opacity
                    masterItem: nvcListView.masterItem? nvcListView.masterItem.createObject(superHeader) : null

                    subItem: nvcListView.subItem? nvcListView.subItem.createObject(superHeader) : null
                    subHeaderColor: nvcListView.backgroundColor

                    shadowColor: nvcListView.foregroundColor
                }
                delegate: Item {
                    width: proxy.object? proxy.object.width : 0
                    height: proxy.object? proxy.object.height : 0

                    Base.ProxyComponent {
                        id: proxy
                        source: nvcListView.delegate
                    }
                }
            }
        }
    }

    CrazyFloatingActionButton {
        id: floatingBtn
        anchors.fill: parent
        flickable: listv
        layoutDirection: nvcListView.layoutDirection

        delegate: Item {
            id: floatingPanel
            anchors.fill: parent
            clip: true

            Base.PointMapListener {
                id: listener
                source: floatingPanel
                dest: floatingBtn
            }

            Item {
                id: blur
                anchors.fill: parent
                visible: false

                FastBlur {
                    x: -listener.result.x + llistFrame.x
                    y: -listener.result.y + llistFrame.y
                    width: llistFrame.width
                    height: llistFrame.height
                    radius: floatingBtn.ratio? 64 : 0
                    source: llistFrame
                    cached: true
                    transform: Scale {
                        xScale: llistFrame.scaleNumber
                        yScale: llistFrame.scaleNumber
                        origin.x: llistFrame.width/2
                        origin.y: llist.y + nvcListView.masterHeaderMinimumHeight
                    }
                }
            }

            Rectangle {
                id: mask
                anchors.fill: parent
                radius: floatingBtn.radius
                visible: false
            }

            OpacityMask {
                anchors.fill: parent
                source: blur
                maskSource: mask
                visible: floatingBtn.ratio
                cached: true
            }

            Rectangle {
                anchors.fill: parent
                opacity: 0.7
                color: nvcListView.backgroundColor
                radius: floatingBtn.radius
            }

            Component.onCompleted: if(panelDelegate) panelDelegate.createObject(this)
        }
    }
}
