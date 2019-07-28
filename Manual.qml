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
        }
        HighEdit {
            id: elev
            x: 20
            Layout.fillWidth: true
            Layout.fillHeight: true

            labelText: "Elevation (Ft.)"
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

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: 45
        color: "#de0b27b4"
        z: -2
    }

    ColumnLayout {
        id: columnLayout
        y: parent.height * (47/55)
        width: parent.width * 0.9
        height: parent.height * (7/55)
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: w1
            width: 167
            height: 22
            color: "#e23030"
            text: qsTr("Required: Dry Bulb")
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
            Layout.fillHeight: false
            Layout.leftMargin: 10
            Layout.topMargin: 0

        }

        Text {
            id: w3
            width: 167
            height: 22
            color: "#e23030"
            text: qsTr("Required: RH or DewPoint or WetBulb")
            Layout.fillHeight: false
            Layout.leftMargin: 10
        }
    }
}





















/*##^## Designer {
    D{i:1;anchors_y:"-8"}D{i:15;anchors_x:160}D{i:16;anchors_x:40;anchors_y:447}D{i:17;anchors_y:470}
}
 ##^##*/
