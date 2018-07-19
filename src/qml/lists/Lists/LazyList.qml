import QtQuick 2.3
import Pinterest.Base 1.0

PinterestItem {
    default property alias contentItem: prv.list

    onContentItemChanged: {
        if(!contentItem)
            return

        data = [contentItem, marea]
        var list = contentItem

        if(list.displayMarginBeginning == 0) list.displayMarginBeginning = 500 * PinterestGlobals.density
        if(list.displayMarginEnd == 0) list.displayMarginEnd = 500 * PinterestGlobals.density
        if(list.delegate) {
            prv.lazyDelegate = list.delegate
            list.delegate = delegate_component
        } else {
            list.delegate = delegate_component
        }
    }

    QtObject {
        id: prv

        property ListView list
        property int mouseIndex

        property real maxVelocity
        property real velocity: {
            if(!list)
                return 0
            switch(list.orientation) {
            case ListView.Horizontal:
                return list.horizontalVelocity
            default:
            case ListView.Vertical:
                return list.verticalVelocity
            }
        }

        property real flicking: list? list.flicking : 0
        property Component lazyDelegate

        onVelocityChanged: {
            if(velocity == 0)
            {
                prv.maxVelocity = 0
                timer.stop()
            }
            else
            if(!timer.running)
                timer.start()
        }
    }

    Timer {
        id: timer
        interval: 20
        repeat: true
        onTriggered: refresh()

        property real maximum: 2000 * PinterestGlobals.density

        function refresh() {
            var res = prv.velocity
            if(res > maximum)
                res = maximum
            else
            if(res < -maximum)
                res = -maximum
            if(prv.flicking)
                res = 0
            prv.maxVelocity = res
        }
    }

    Component {
        id: delegate_component
        Item {
            width: proxy.object? proxy.object.width : 1
            height: proxy.object? proxy.object.height : 1
            z: proxy.object? proxy.object.z : 0

            property int index: model.index

            Item {
                width: parent.width
                height: parent.height

                y: {
                    if(prv.list.orientation == ListView.Vertical)
                        return value
                    else
                        return 0
                }
                x: {
                    if(prv.list.orientation == ListView.Horizontal)
                        return value
                    else
                        return 0
                }

                property real value: {
                    var baseIdx = prv.mouseIndex - index
                    var res = baseIdx * -Math.abs(prv.maxVelocity)/40
                    return res
                }

                Behavior on value {
                    NumberAnimation { easing.type: Easing.OutBack; duration: 300 }
                }

                ProxyComponent {
                    id: proxy
                    source: prv.lazyDelegate
                }
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    mouse.accepted = false
                    prv.mouseIndex = index
                }
            }
        }
    }

    MouseArea {
        id: marea
        visible: contentItem.flicking
        anchors.fill: contentItem? contentItem : undefined
        onPressed: {
            var y = mouseY + contentItem.contentY
            var x = mouseX + contentItem.contentX
            var item = contentItem.itemAt(x, y)
            mouse.accepted = false
            if(item)
            {
                prv.mouseIndex = item.index
                timer.stop()
                prv.maxVelocity = 0
            }
        }
    }
}
