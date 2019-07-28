import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Item {
    id: element
    width: 360
    height: 550
    clip: false






    Label {
        id: label
        x: 139
        y: 16
        width: 204
        height: 27
        text: qsTr("Mechanical Cooling")
        font.pointSize: 14
    }

    Switch {
        id: element1
        x: 204
        y: 55
        width: 52
        height: 30
    }

    Label {
        id: label2
        x: 22
        y: 16
        width: 69
        height: 27
        text: qsTr("STAGE")
        font.pointSize: 14
    }

    Label {
        id: label3
        x: 22
        y: 56
        width: 69
        height: 27
        text: qsTr("STATE")
        font.pointSize: 14
    }

    ColumnLayout {
        id: columnLayout
        x: 22
        y: 98
        width: 321
        height: 437

        HighLabel {
            id: highLabel
            x: 23
            y: 132
            labelText: "Sensible Heat"
        }

        HighLabel {
            id: highLabel1
            x: 23
            y: 132
            labelText: "Latent Hea"
        }

        HighLabel {
            id: highLabel2
            x: 23
            y: 132
            labelText: "Dry Bulb"
        }

        HighLabel {
            id: highLabel3
            x: 23
            y: 132
            labelText: "RH"
        }

        HighLabel {
            id: highLabel4
            x: 23
            y: 132
        }

        HighLabel {
            id: highLabel5
            x: 23
            y: 132
            labelText: "Wet Bulb"
        }

        HighLabel {
            id: highLabel6
            x: 23
            y: 132
            labelText: "HR"
        }

        HighLabel {
            id: highLabel7
            x: 23
            y: 132
            labelText: "Enthalpy"
        }
    }








}
