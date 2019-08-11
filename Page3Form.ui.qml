import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Page {
    id: p3
    height: 600
    property alias p3: p3
    property alias manualButton: manualButton
    property alias clearBtn: clearBtn
    property alias next: next
    property alias back: back
    property alias manualView: manualView
    property alias second: second
    property alias manual: manual

    width: 360

    StackView {
        id: manualView
        width: parent.width
        height: parent.height * (55 / 60)

        initialItem: manual

        Manual {
            id: manual
            height: manualView.height
            width: manualView.width
        }

        Second {
            id: second
            visible: false
            height: parent.height
            width: parent.width
        }
    }

    Button {
        y: 553 / 600 * parent.height
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 70 / 360 * parent.width
        height: 44 / 600 * parent.height
        id: clearBtn
        Layout.fillHeight: false
        Layout.leftMargin: 10
        background: Rectangle {
            color: "#de0b27b4"
        }
        font.family: voyager.name
        contentItem: Text {

            color: "#ffffff"
            text: qsTr("CLEAR")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 11
        }
        visible: true
    }

    Button {
        y: 553 / 600 * parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        width: 113 / 360 * parent.width
        height: 44 / 600 * parent.height
        id: manualButton
        background: Rectangle {
            color: "#de0b27b4"
        }
        font.family: voyager.name
        contentItem: Text {
            color: "#ffffff"
            text: qsTr("CALCULATE")
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.HorizontalFit
            font.pointSize: 11
            verticalAlignment: Text.AlignVCenter
        }
        visible: true
    }

    Button {
        y: 553 / 600 * parent.height
        height: 44 / 600 * parent.height
        width: 61 / 360 * parent.width
        id: next
        text: "NEXT"
        anchors.right: parent.right
        anchors.rightMargin: 10
        background: Rectangle {
            color: "#de0b27b4"
        }
        font.family: voyager.name
        contentItem: Text {
            color: "#ffffff"
            text: qsTr("NEXT")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 11
        }
        visible: true
    }

    Button {
        id: back
        x: 14 / 360 * parent.width
        y: 553 / 600 * parent.height
        height: 44 / 600 * parent.height
        width: 63 / 360 * parent.width

        text: "BACK"
        visible: false
        background: Rectangle {
            color: "#de0b27b4"
        }

        contentItem: Text {
            color: "#ffffff"
            text: qsTr("BACK")
            visible: true
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 11
        }
        font.family: voyager.name
    }
}
