import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    id: p1
    width: 360
    height: 600
    property alias p1: p1
    property alias third: third
    property alias second: second
    property alias nb: next
    property alias back: back
    property alias first: first
    property alias stackView: stackView

    StackView {
        id: stackView
        y: 0
        height: parent.height * (55 / 60)
        clip: true
        initialItem: first
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.left: parent.left

        First {
            id: first
            x: 0
            y: 0
            height: parent.height
            width: parent.width
        }

        Second {
            id: second
            x: 0
            y: 0
            visible: false
            height: parent.height
            width: parent.width
        }
        Third {
            id: third
            x: 0
            z: 0
            visible: false
        }
    }

    Button {
        id: next
        x: parent.width * (285 / 360)
        y: parent.height * (552 / 600)
        width: 61 / 360 * parent.width
        height: 44 / 600 * parent.height
        contentItem: Text {
            text: qsTr("NEXT")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            color: "white"
        }
        font.family: voyager.name

        background: Rectangle {
            color: "#de0b27b4"
            radius: 4
        }
    }

    Button {
        id: back
        x: parent.width * (15 / 360)
        y: parent.height * (552 / 600)
        width: 63 / 360 * parent.width
        height: 44 / 600 * parent.height

        visible: false
        background: Rectangle {
            color: "#de0b27b4"
            radius: 4
        }

        contentItem: Text {
            color: "#ffffff"
            text: qsTr("BACK")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
        }
        font.family: voyager.name
    }
}
