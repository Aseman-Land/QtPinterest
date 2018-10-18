import QtQuick 2.0
import Pinterest.Base 1.0 as Base

Base.PinterestItem {
    id: item
    clip: true

    property color color: "#0d80ec"
    property color panelColor: "#fff"
    property alias text: txt.text
    property alias font: txt.font
    property alias textColor: txt.color
    property real radius: 8*Base.PinterestGlobals.density
    property real horizontalPadding: 20*Base.PinterestGlobals.density
    property real verticalPadding: 20*Base.PinterestGlobals.density

    property int horizontalAlignment: layoutDirection==Qt.LeftToRight? Qt.AlignRight : Qt.AlignRight
    property real panelHeight: btn.openedWidth

    property Flickable flickable

    property Component delegate
    property Item delegateItem

    property int animationDuration: 350

    property bool opened: false
    property real ratio: opened? 1 : 0

    property int easingType: Easing.InOutSine

    Behavior on ratio {
        NumberAnimation { easing.type: easingType; duration: animationDuration }
    }

    Connections {
        id: flickConnection
        target: flickable
        onContentYChanged: {
            if(!lastContentYSetuped) {
                lastContentY = flickable.contentY
                lastContentYSetuped = true
                return
            }

            var delta = flickable.contentY - lastContentY
            var newPaddingY = paddingY
            newPaddingY += delta
            if(newPaddingY < -unPaddingY)
                newPaddingY = -unPaddingY
            if(newPaddingY > maxPaddingY)
                newPaddingY = maxPaddingY

            paddingY = newPaddingY
            lastContentY = flickable.contentY
        }

        property real paddingY
        property real maxPaddingY: btn.height + 40*Base.PinterestGlobals.density
        property real unPaddingY: 400*Base.PinterestGlobals.density
        property bool lastContentYSetuped
        property real lastContentY
    }

    Base.FastRectengleShadow {
        anchors.centerIn: btn
        width: btn.closedWidth
        height: width
        roundRadius: width/2
        radius: 32
        color: "#333"
        cached: true
        opacity: 0.7
        verticalOffset: 3 * Base.PinterestGlobals.density
    }

    Base.FastRectengleShadow {
        anchors.centerIn: btn
        width: btn.openedWidth
        height: width
        roundRadius: item.radius
        radius: 32
        color: "#333"
        cached: true
        opacity: btn.secondRatio*0.7
        scale: btn.secondRatio * (btn.closedWidth/btn.openedWidth)
        verticalOffset: 3 * Base.PinterestGlobals.density
    }

    Rectangle {
        anchors.fill: parent
        opacity: btn.secondRatio*0.5
        color: "#000"
    }

    MouseArea {
        anchors.fill: parent
        visible: btn.secondRatio
        onClicked: toggle()
    }

    Rectangle {
        id: btn
        clip: true
        x: {
            var sec = (parent.width/2 - openedWidth/2) * secondRatio
            var mid = (parent.width/2 - closedWidth/2) * midRatio
            var defaultLayout = (item.layoutDirection == Qt.LeftToRight)
            var fst = 0
            switch(horizontalAlignment) {
            case Qt.AlignLeft:
                fst = 20*Base.PinterestGlobals.density
                break;
            case Qt.AlignHCenter:
            case Qt.AlignCenter:
                fst = parent.width/2 - width/2
                break;
            default:
            case Qt.AlignRight:
                fst = parent.width - closedWidth - 20*Base.PinterestGlobals.density
                break;
            }
            fst = fst*firstRatio

            return fst + mid + sec
        }
        y: {
            var sec = (parent.height - panelHeight - item.verticalPadding) * secondRatio
            var mid = (parent.height - panelHeight/2 - closedWidth/2) * midRatio
            var fst = parent.height - closedWidth - 20*Base.PinterestGlobals.density
            var padY = flickConnection.paddingY
            if(padY < 0)
                padY = 0

            fst = (fst + padY) * firstRatio
            return fst + mid + sec
        }
        width: secondRatio*openedWidth + (1-secondRatio)*closedWidth
        height: secondRatio*panelHeight + (1-secondRatio)*closedWidth
        radius: secondRatio*item.radius + (1-secondRatio)*closedWidth/2
        color: secondRatio? item.panelColor : item.color

        property real firstRatio: {
            var ratio = 1 - item.ratio*2
            if(ratio < 0)
                ratio = 0
            return ratio
        }
        property real midRatio: {
            var ratio = item.ratio*2
            if(ratio > 1)
                ratio = 1
            ratio -= secondRatio
            return ratio
        }
        property real secondRatio: {
            var ratio = item.ratio*2 - 1
            if(ratio < 0)
                ratio = 0
            return ratio
        }

        property bool opened: item.opened || item.ratio
        property real openedWidth: Math.min(item.width, item.height) - item.horizontalPadding*2
        property real closedWidth: 62 * Base.PinterestGlobals.density
        property bool inited: false

        onOpenedChanged: {
            if(opened)
                createItem()
            else
                destroyItem()
        }

        Behavior on color {
            ColorAnimation { easing.type: easingType; duration: animationDuration/2 }
        }

        Text {
            id: txt
            anchors.centerIn: parent
            color: "#fff"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: if(btn.firstRatio) toggle()
        }

        Timer {
            interval: animationDuration/2
            repeat: false
            running: true
            onTriggered: btn.inited = true
        }

        Item {
            id: scene
            width: btn.openedWidth
            height: panelHeight
            anchors.centerIn: parent
            visible: opacity > 0
            opacity: {
                if(btn.secondRatio)
                    return btn.secondRatio
                else
                    return btn.opened? 0.01 : 0
            }
        }

        function createItem() {
            destroyItem()
            if(!delegate)
                return

            delegateItem = delegate.createObject(scene)
        }

        function destroyItem() {
            if(!delegateItem)
                return

            delegateItem.destroy()
        }
    }

    function toggle() {
        opened = !opened
    }
}
