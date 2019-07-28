import QtQuick 2.12
import QtQuick.Controls 2.12


Item {
    id: element
    width: 237
    height: 36

    Rectangle {
        id: rectangle
        color: "#ffffff"
        border.color: "#e6e6e6"
        border.width: 1
        anchors.fill: parent

        Text {
            id: city
            x: 36
            y: 2
            width: 200
            height: 32
            text: cityName
            font.family: stellar.name
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pixelSize: 24
        }
    }

    Image {
        id: image
        x: 0
        y: 2
        width: 32
        anchors.verticalCenter: parent.verticalCenter
        source: "pin.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {

        }
    }

}







/*##^## Designer {
    D{i:1;anchors_height:200;anchors_width:200;anchors_x:29;anchors_y:8}
}
 ##^##*/
