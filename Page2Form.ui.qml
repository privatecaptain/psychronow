import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    id: p2
    width: 360
    height: 600
    property alias p2: p2
    property alias back: back
    property alias next: next
    property alias locaView: locaView
    property alias third: third
    property alias second: second
    property alias first: first
    property alias location: location

    StackView {
        id: locaView
        height: 550 / 600 * parent.height
        clip: true
        anchors.bottomMargin: 49
        anchors.fill: parent
        initialItem: location
        Location {
            id: location
            x: 0
            y: 0
            width: parent.width
            height: parent.height
        }

        First {
            id: first
            visible: false
            width: parent.width
            height: parent.height
        }

        Second {
            id: second
            visible: false
            width: parent.width
            height: parent.height
        }

        Third {
            id: third
            visible: false
        }
    }
    Button {
        id: next
        x: 285 / 360 * parent.width
        y: 552 / 600 * parent.height
        visible: false
        contentItem: Text {
            text: qsTr("NEXT")
            color: "white"
        }
        font.family: voyager.name

        background: Rectangle {
            color: "#de0b27b4"
        }
    }

    Button {
        id: back
        x: 15 / 360 * parent.width
        y: 552 / 600 * parent.height
        visible: false
        background: Rectangle {
            color: "#de0b27b4"
        }

        contentItem: Text {
            color: "#ffffff"
            text: qsTr("BACK")
        }
        font.family: voyager.name
    }
}
