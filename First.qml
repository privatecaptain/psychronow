import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Item {
    id: element
    width: 360
    height: 550
    property alias loading: loading
    property alias elev: elev
    property alias unitSwitch: unitSwitch
    property alias humidity: humidity
    property alias enthalpy: enthalpy
    property alias hr: hr
    property alias wetbulb: wetbulb
    property alias dewpoint: dewpoint
    property alias rh: rh
    property alias drybulb: drybulb
    property alias city: label
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

    function elevM(e){
        e = parseFloat(e)/3.289;
        return e.toFixed(1);
    }


    function metric(){
        drybulb.elementText = toC(drybulb.real)
        wetbulb.elementText = toC(wetbulb.real)
        dewpoint.elementText = toC(dewpoint.real)
        enthalpy.elementText = uen(enthalpy.real,1)
        humidity.elementText = uhum(humidity.real,1)

        drybulb.labelText = drybulb.labelText.replace('F','C')

        wetbulb.labelText =  wetbulb.labelText.replace('F','C')
        dewpoint.labelText =  dewpoint.labelText.replace('F','C')
        enthalpy.labelText =  enthalpy.labelText.replace('Btu/lb','KJ/Kg')
        humidity.labelText =  humidity.labelText.replace('grain/lb','G/Kg')
        hr.labelText = hr.labelText.replace('lbw/lba','Kgw/Kga')
        elev.text = elevM(elevation) + " M";

    }

    function imperial(){
        drybulb.elementText =   drybulb.real
        wetbulb.elementText =  wetbulb.real
        dewpoint.elementText =   dewpoint.real
        enthalpy.elementText =   enthalpy.real
        humidity.elementText =   humidity.real

        drybulb.labelText = drybulb.labelText.replace('C','F')

        wetbulb.labelText =  wetbulb.labelText.replace('C','F')
        dewpoint.labelText =  dewpoint.labelText.replace('C','F')
        enthalpy.labelText =  enthalpy.labelText.replace('KJ/Kg','Btu/lb')
        humidity.labelText =  humidity.labelText.replace('G/Kg','grain/lb')
        hr.labelText = hr.labelText.replace('Kgw/Kga','lbw/lba')
        elev.text = elevation.toFixed(1) + " Ft.";


    }

    Image {
        id: image1
        x: 93
        y: 3
        width: 32
        anchors.verticalCenterOffset: 56
        anchors.verticalCenter: label.verticalCenter
        source: "altitude.png"
        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: label
        x: 128
        y: 23
        width: 0
        height:  39
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.NoWrap
        verticalAlignment: Text.AlignVCenter
        font.family: sb.name
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 22
    }

    Label {
        id: elev
        x: 153
        y: 3
        height: 32
        text: qsTr("0 Ft.")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 56
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: label.verticalCenter
        font.family: stellar.name
        font.pointSize: 22
    }

    Switch {
        id: unitSwitch
        x: 153
        y: 162
        width: 122
        height: 43
        text: qsTr("Metric")
        font.family: stellar.name
        font.pointSize: 15
    }
    Label {
        id: label2
        x: 86
        y: 63
        text: qsTr("Imperial")
        anchors.verticalCenterOffset: 0
        font.family: stellar.name
        anchors.verticalCenter: unitSwitch.verticalCenter
        font.pointSize: 15
    }


    BusyIndicator {
        id: loading
        x: 20
        y: 533
        width: 100
        height: 100
        z: 6
        running: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ColumnLayout {
        id: rowLayout
        x: 0
        y: 211
        width: parent.width * (320/360)
        height: parent.height * (331/550)
        anchors.horizontalCenter: parent.horizontalCenter

        HighLabel {
            id: drybulb
            x: 35
            y: 230
            Layout.fillWidth: true
            elementText: ""
            labelText: "Dry Bulb (°F)"
        }

        HighLabel {
            id: rh
            x: 35
            y: 230
            Layout.fillWidth: false
            Layout.rowSpan: 1
            elementText: ""
            labelText: "RH (%)"
        }

        HighLabel {
            id: dewpoint
            x: 35
            y: 230
            Layout.fillWidth: false
            elementText: ""
        }

        HighLabel {
            id: wetbulb
            x: 35
            y: 230
            Layout.fillWidth: true
            elementText: ""
            labelText: "Wet Bulb (°F)"
        }

        HighLabel {
            id: hr
            x: 35
            y: 230
            Layout.fillWidth: true
            elementText: ""
            labelText: "HR (lbw/lba)"
        }

        HighLabel {
            id: enthalpy
            x: 35
            y: 230
            Layout.fillWidth: true
            elementText: ""
            labelText: "Enthalpy (Btu/lb)"
        }

        HighLabel {
            id: humidity
            x: 35
            y: 230
            Layout.fillWidth: true
            elementText: ""
            labelText: "Humidity (grain/lb)"
        }
    }

    Image {
        id: gpsIcon
        x: 0
        y: 27
        width: 32
        source: "navigation.png"
        fillMode: Image.PreserveAspectFit
    }









}








































