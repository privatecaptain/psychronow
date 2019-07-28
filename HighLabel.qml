import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
Item {
    id: element1
    width: 320
    height: 40
    property alias elementText: element.text
    property alias labelText: label.text

    //    property alias unit: uni.text

    property real real: 0
    Rectangle {
        id: rectangle
        x: 10
        y: 37
        width: parent.width - 20
        height: parent.height / 20
        color: "#d4d0d0"
        anchors.horizontalCenter: parent.horizontalCenter
    }

        Label {
            id: label
            width: parent.width * (185/320)
            height: parent.height *  (36/40)
            color: "#de0b27b4"
            text: qsTr("Dew Point(°F)")
            font.pointSize: 20
            fontSizeMode: Text.FixedSize
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.leftMargin: 10
            Layout.leftMargin: 10
            Layout.fillWidth: false
            Layout.fillHeight: true

            wrapMode: Text.NoWrap
            font.family: sb.name
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: element
            x: 288
            y: 0
            width: 60
            height: 37
            text: "0"
            rightPadding: 20
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: 10
            Layout.fillHeight: true
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            font.family: voyager.name
        }
    }












































