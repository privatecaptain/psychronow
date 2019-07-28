import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12


Item {
    width: 64
    height: 64
    property alias mouseAreaEnabled: mouseArea.enabled

    Image {
        id: image
        x: 0
        y: 0
        fillMode: Image.PreserveAspectFit
        source: "right-arrow (1).png"
    }

    MouseArea {
        id: mouseArea
        x: 0
        y: 0
        width: 64
        height: 64
    }

}
