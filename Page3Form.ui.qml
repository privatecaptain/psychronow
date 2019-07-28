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
        }
    }

    RowLayout {
        id: row
        y: parent.height * (55 / 60)
        width: parent.width
        height: parent.height * (5 / 60)
        spacing: 5

        Button {
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
            }
            visible: true
        }

        Button {
            id: manualButton
            Layout.fillHeight: false
            Layout.leftMargin: 48
            background: Rectangle {
                color: "#de0b27b4"
            }
            font.family: voyager.name
            contentItem: Text {
                color: "#ffffff"
                text: qsTr("CALCULATE")
                verticalAlignment: Text.AlignVCenter
            }
            visible: true
        }

        Button {
            id: next
            text: "NEXT"
            Layout.fillHeight: false
            Layout.leftMargin: 36
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 10
            background: Rectangle {
                color: "#de0b27b4"
            }
            font.family: voyager.name
            contentItem: Text {
                color: "#ffffff"
                text: qsTr("NEXT")
                verticalAlignment: Text.AlignVCenter
            }
            visible: true
        }
    }

    RowLayout {
        id: rowLayout
        x: 0
        y: parent.height * (55 / 60)
        width: parent.width
        height: parent.height * (5 / 60)
        spacing: 5

        Button {
            id: back
            text: "BACK"
            Layout.leftMargin: 10
            Layout.fillHeight: false
            visible: false
            background: Rectangle {
                color: "#de0b27b4"
            }

            contentItem: Text {
                color: "#ffffff"
                text: qsTr("BACK")
                visible: true
                verticalAlignment: Text.AlignVCenter
            }
            font.family: voyager.name
        }
    }
}
