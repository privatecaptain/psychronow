import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12


Item {
    property alias name: name.text
    width: 100
    height: 60
    property alias image: image.source

    Image {
        id: image
        x: 0
        y: 0
        width: 100
        height: 45
        fillMode: Image.Stretch
        source: "tt.png"
    }

    Text {
        id: name
        x: 0
        y: 47
        width: 100
        text: qsTr("Toronto")
        fontSizeMode: Text.Fit
        font.family: stellar.name
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }



}









/*##^## Designer {
    D{i:1;anchors_height:100;anchors_width:100;anchors_x:16;anchors_y:8}
}
 ##^##*/
