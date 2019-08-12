import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Item {
    id: element4

    height: 550
    width: 360
    property alias w3: w3
    property alias w2: w2
    property alias w1: w1
    property alias unitSwitch: unitSwitch
    property alias humidity: humidity
    property alias en: en
    property alias hr: hr
    property alias dewpoint: dewpoint
    property alias wb: wb
    property alias elev: elev
    property alias rh: rh
    property alias db: db

    property real elevation: 0

//    property QtObject foc: 0

    property var af: 0;
    function toC(f){
        f = parseFloat(f);
        var c = (f -32)*(5/9);
        return c.toFixed(1);
    }

    function toF(c){
        c = parseFloat(c);
        var f = (c*9/5) + 32;
        return f.toFixed(1)
    }

    function uen(btu,u){
        btu = parseFloat(btu);
        if(u){
            btu = btu * 2.326;
        }else{
            btu = btu / 2.326;
        }

        return btu.toFixed(1);
    }


    function uhum(hum,u){
        hum  = parseFloat(hum);

        if(u){
            hum = hum / 7;
        }else{
            hum = hum * 7;
        }
        return hum.toFixed(1);
    }



    function metric(wet,dew){

        if(wet){
            wb.textField.text = toC(wb.textField.text)
        }
        if(dew){
            dewpoint.textField.text = toC(dewpoint.textField.text)
        }
        en.elementText = uen(en.elementText,1)
        humidity.elementText = uhum(humidity.elementText,1)

    }

    function metricLabel(){
        db.labelText = db.labelText.replace('F','C')
        elev.labelText = elev.labelText.replace('Ft','M');
        wb.labelText =  wb.labelText.replace('F','C')
        dewpoint.labelText =  dewpoint.labelText.replace('F','C')
        en.labelText =  en.labelText.replace('Btu/lb','KJ/Kg')
        humidity.labelText =  humidity.labelText.replace('grain/lb','G/Kg')
        hr.labelText = hr.labelText.replace('lbw/lba','Kgw/Kga')

    }

    function imperialLabel(){
        db.labelText = db.labelText.replace('C','F')
        elev.labelText = elev.labelText.replace('M','Ft');
        wb.labelText =  wb.labelText.replace('C','F')
        dewpoint.labelText =  dewpoint.labelText.replace('C','F')
        en.labelText =  en.labelText.replace('KJ/Kg','Btu/lb')
        humidity.labelText =  humidity.labelText.replace('G/Kg','grain/lb')
        hr.labelText = hr.labelText.replace('Kgw/Kga','lbw/lba')

    }



    Text {
        id: element

        width: 120
        height: 64
        color: "#ffffff"
        text: qsTr("Manual")
        anchors.top: parent.top
        anchors.topMargin: -8
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: stellar.name
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 36
    }


    Switch {
        id: unitSwitch
        x: 185
        y: 44
        width: 140
        height: 43
        text: qsTr("Metric")
        anchors.horizontalCenterOffset: 52
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: stellar.name
        font.pointSize: 15
    }
    Label {
        id: label2
        x: 86
        y: 63
        text: qsTr("Imperial")
        anchors.right: unitSwitch.left
        anchors.rightMargin: 20
        anchors.verticalCenterOffset: 0
        font.family: stellar.name
        anchors.verticalCenter: unitSwitch.verticalCenter
        font.pointSize: 15
    }
    ColumnLayout {
        id: column
        x: 0
        y: 92
        width: parent.width * 0.9
        height: parent.height * (380/550)
        anchors.horizontalCenter: parent.horizontalCenter

        HighEdit {
            id: db
            x: 20
            Layout.fillHeight: true

            Layout.fillWidth: true
            labelText: "Dry Bulb (°F)"
            textField.onPressed: {
                showDone();
                af = db;
            }

        }

        HighEdit {
            id: rh
            x: 20
            Layout.fillWidth: true
            Layout.fillHeight: true

            labelText: "RH (%)"
            textField.onActiveFocusChanged:  {
                if(textField.activeFocus){
                    wb.textField.clear();
                    dewpoint.textField.clear();
                }
            }
            textField.onPressed: {
                showDone();
                af = rh;

            }

        }
        HighEdit {
            id: elev
            x: 20
            Layout.fillWidth: true
            Layout.fillHeight: true

            labelText: "Elevation (Ft.)"
            textField.onPressed: {
                showDone();
                af = elev;

            }

        }

        HighEdit {
            id: wb
            x: 20
            Layout.fillWidth: true
            Layout.fillHeight: true

            labelText: "Wet Bulb (°F)"
            textField.onActiveFocusChanged:  {
                if(textField.activeFocus){
                    rh.textField.clear();
                    dewpoint.textField.clear();
                }
            }
            textField.onPressed: {
                showDone();
                af = wb;

            }

        }

        HighEdit {
            id: dewpoint
            x: 20
            Layout.fillWidth: true
            Layout.fillHeight: true

            labelText: "Dew Point (°F)"
            textField.onActiveFocusChanged:  {
                if(textField.activeFocus){
                    wb.textField.clear();
                    rh.textField.clear();
                }
            }
            textField.onPressed: {
                showDone();
                af = dewpoint;

            }

        }



        HighLabel {
            id: hr
            x: 26
            Layout.fillWidth: true
            Layout.fillHeight: true

            elementText: ""
            labelText: "HR (lbw/lba)"
        }

        HighLabel {
            id: en
            x: 26
            Layout.fillWidth: true

            Layout.fillHeight: true
            elementText: ""
            labelText: "Enthalpy (Btu/lb)"
        }

        HighLabel {
            id: humidity
            x: 26
            Layout.fillWidth: true
            Layout.fillHeight: true

            elementText: ""
            labelText: "Humidity (grain/lb)"
        }


    }

    function showDone(){
        done.visible = true;
        white.visible = true;
        negative.visible = true;
    }

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: 45
        color: "#de0b27b4"
        z: -2
    }



        Text {
            id: w1
            width: 167
            height: 22
            color: "#e23030"
            text: qsTr("Required: Dry Bulb")
            fontSizeMode: Text.Fit
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: column.bottom
            anchors.topMargin: 10
            Layout.fillHeight: false
            Layout.fillWidth: false
            Layout.leftMargin: 10
        }

        Text {
            id: w2
            width: 167
            height: 22
            color: "#e23030"
            text: qsTr("Required: Elevation")
            fontSizeMode: Text.Fit
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: w1.bottom
            anchors.topMargin: 2
            Layout.fillHeight: false
            Layout.leftMargin: 10
            Layout.topMargin: 0

        }

        Text {
            id: w3
            width: 312
            height: 22
            color: "#e23030"
            text: qsTr("Required: RH or DewPoint or WetBulb")
            fontSizeMode: Text.Fit
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: w2.bottom
            anchors.topMargin: 2
            Layout.fillHeight: false
            Layout.leftMargin: 10
        }

        Button {
            id: done
            x: 150
            y: 380 / 550 * parent.height
            width: 61 / 360 * parent.width
            height: 44 / 550 * parent.height
            text: "DONE"
            anchors.right: parent.right
            anchors.rightMargin: 100
            z: 1
            flat: false
            highlighted: true
            font.family: voyager.name
            background: Rectangle {
                color: "#ffffff"
                radius: 4
                border.color: "#e9e8e8"
                border.width: 1
            }
            visible: true
            contentItem: Text {
                color: "#000000"
                text: qsTr("DONE")
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
            }


            onClicked: {
                done.visible = false;
                white.visible = false;
                negative.visible = false;
            }

        }
        Rectangle {
            id: white
            width: parent.width
            height: done.height

            color: "#d1d2d7"
            visible: true
            z: 0
            anchors.verticalCenter: done.verticalCenter
        }

        Button {
            id: negative
            y: 7
            width: 61 / 360 * parent.width
            height: 44 / 550 * parent.height
            text: "DONE"
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.verticalCenter: done.verticalCenter
            font.family: voyager.name
            highlighted: true
            background: Rectangle {
                color: "#ffffff"
                radius: 4
                border.color: "#e9e8e8"
                border.width: 1
            }
            visible: true
            contentItem: Text {
                color: "#000000"
                text: qsTr(" – / +")
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
            }
            z: 1
            MouseArea{
                anchors.fill: parent
                onClicked: {

                        af.neg();

                }
            }
        }

}











































































/*##^## Designer {
    D{i:1;anchors_y:"-8"}D{i:14;anchors_width:167;anchors_y:470}D{i:21;anchors_x:152}
}
 ##^##*/
