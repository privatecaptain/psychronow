import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
Item {
    id: element1
    width: 360
    height: 40
    property alias indirect: element.text
    property alias direct: element2.text
    property alias labelText: label.text

    property real dreal: 0
    property real ireal: 0

    Label {
        id: label
        x: 10
        y: 0
        height: 36
        color: "#de0b27b4"
        text: qsTr("Dew Point ")
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: Text.WordWrap
        font.family: sb.name
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
    }

    Text {
        id: element
        y: 4
        text: "0"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 202
        font.pointSize: 20
        font.family: voyager.name
    }
    Rectangle {
        id: rectangle
        x: 5
        y: 37
        width: 350
        height: 2
        color: "#d4d0d0"
        anchors.horizontalCenter: parent.horizontalCenter
    }



    Text {
        id: element2
        x: 2
        y: 11
        text: "0"
        anchors.verticalCenterOffset: 0
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 20
        font.family: voyager.name
        anchors.leftMargin: 294
    }



}

























































/*##^## Designer {
    D{i:2;anchors_x:252}
}
 ##^##*/
