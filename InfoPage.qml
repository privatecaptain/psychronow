import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: element
    width: 360
    height: 600

    Image {
        id: image
        x: 130
        y: 250/600 * parent.height
        width: 200/600 * parent.height
        height: 200/600 * parent.height
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "air2o-logo-full.png"
    }

    Text {
        id: element1
        x: 105
        color: "#de0b27b4"
        text: qsTr("About Us")
        fontSizeMode: Text.Fit
        anchors.top: parent.top
        anchors.topMargin: 39
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 36
    }

    Text {
        id: element2
        x: 58
        y: 122/600 * parent.height
        width: 272
        height: 194/600 * parent.height
        text: qsTr("The next generation hybrid air conditioning system
When your project calls for the most efficient and environmentally responsible 100% Fresh Air Cooling system to any residential, commercial or industrial application, Air2O is a world leading next generation hybrid air conditioning system with unparalleled performance and eco credentials.")
        fontSizeMode: Text.Fit
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: Text.WordWrap
        font.pixelSize: 15
        font.family: stellar.name
    }

    Text {
        id: element3
        x: 76
        y: 462/600 * parent.height
        text: qsTr("8355 E Butherus Drive,  Suite 2
Scottsdale, Arizona    85260
1-(602)-699-3766

")
        fontSizeMode: Text.Fit
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 15
    }

    Text {
        id: element4
        x: 87
        y: 547/600 * parent.height
        text: qsTr("© 2019 Air2O All Rights Reserved.

")
        fontSizeMode: Text.Fit
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 13
    }

    Image {
        id: image1
        x: 261
        width: 32/600 * parent.height
        height: 32/600 * parent.height
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        fillMode: Image.PreserveAspectFit
        source: "cancel.png"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                element.visible = false;
            }
        }
    }

}














