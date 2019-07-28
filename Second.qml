import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Item {
    id: element
    width: 360
    height: 550
    property alias wbEff: wbEff
    property alias dewEff: dewEff
    property alias humidity: humidity
    property alias en: en
    property alias hr: hr
    property alias wb: wb
    property alias dewpoint: dewpoint
    property alias rh: rh
    property alias db: db
    property alias effectivness: effectivness
    property alias directSwitch: directSwitch
    property alias indirectSwitch: indirectSwitch
    clip: false






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




    function metric(){
        db.indirect = toC(db.ireal)
        wb.indirect = toC(wb.ireal)
        dewpoint.indirect = toC(dewpoint.ireal)
        en.indirect = uen(en.ireal,1)
        humidity.indirect = uhum(humidity.ireal,1)

        db.direct = toC(db.dreal)
        wb.direct = toC(wb.dreal)
        dewpoint.direct = toC(dewpoint.dreal)
        en.direct = uen(en.dreal,1)
        humidity.direct = uhum(humidity.dreal,1)

        db.labelText = db.labelText.replace('F','C')

        wb.labelText =  wb.labelText.replace('F','C')
        dewpoint.labelText =  dewpoint.labelText.replace('F','C')
        en.labelText =  en.labelText.replace('Btu/lb','KJ/Kg')
        humidity.labelText =  humidity.labelText.replace('grain/lb','G/Kg')
        hr.labelText = hr.labelText.replace('lbw/lba','Kgw/Kga')

    }

    function imperial(){
        db.direct = db.dreal
        wb.direct = wb.dreal
        dewpoint.direct = dewpoint.dreal
        en.direct = en.dreal
        humidity.direct = humidity.dreal
        rh.direct = rh.dreal
        hr.direct = hr.dreal

        db.indirect = db.ireal
        wb.indirect = wb.ireal
        dewpoint.indirect = dewpoint.ireal
        en.indirect = en.ireal
        humidity.indirect = humidity.ireal
        rh.indirect = rh.ireal
        hr.indirect = hr.ireal


        db.labelText = db.labelText.replace('C','F')

        wb.labelText =  wb.labelText.replace('C','F')
        dewpoint.labelText =  dewpoint.labelText.replace('C','F')
        en.labelText =  en.labelText.replace('KJ/Kg','Btu/lb')
        humidity.labelText =  humidity.labelText.replace('G/Kg','grain/lb')
        hr.labelText = hr.labelText.replace('Kgw/Kga','lbw/lba')

    }


    ColumnLayout {
        id: rowLayout
        x: 0
        y: 100 * parent.height / 550
        width: parent.width
        height: parent.height * 331 / 550

        High2{
            id: effectivness
            direct: "95"
            indirect:  "80"
            labelText: "Effectiveness (%)"
        }

        High2 {
            id: db
            x: 0
            y: 17
            labelText: "Dry Bulb (°F)"
        }

        High2 {
            id: rh
            x: 0
            y: 17
            labelText: "RH (%)"
        }

        High2 {
            id: dewpoint
            x: 0
            y: 17
            labelText: "Dew Point (°F)"
        }

        High2 {
            id: wb
            x: 0
            y: 17
            labelText: "Wet Bulb (°F)"
        }

        High2 {
            id: hr
            x: 0
            y: 17
            labelText: "HR (lbw/lba)"
        }

        High2 {
            id: en
            x: 0
            y: 17
            labelText: "Enthalpy (Btu/lb)"
        }

        High2 {
            id: humidity
            x: 0
            y: 17
            labelText: "Humidity (grain/lb)"
        }
    }

    Label {
        id: label
        x: parent.width * 181 /360
        y: parent.height * 16/550
        width: 84
        height: 27
        text: qsTr("Indirect")
        font.family: sb.name
        font.pointSize: 14
    }

    Label {
        id: label1
        x: 293  * parent.width  / 360
        y: 16  * parent.height / 550
        width: 67
        height: 27
        text: qsTr("Direct")
        font.family: sb.name
        font.pointSize: 14
    }

    Switch {
        id: indirectSwitch
        x: 177 * parent.width  / 360
        y: 54 * parent.height / 550
        width: 52
        height: 30
    }

    Switch {
        id: directSwitch
        x: 288 * parent.width  / 360
        y: 54 * parent.height / 550
        width: 52
        height: 30
    }

    Label {
        id: label2
        x: 22 * parent.width  / 360
        y: 16 * parent.height / 550
        width: 69
        height: 27
        text: qsTr("STAGE")
        font.family: sb.name
        font.pointSize: 14
    }

    Label {
        id: label3
        x: 22 * parent.width  / 360
        y: 56 * parent.height / 550
        width: 69
        height: 27
        text: qsTr("STATE")
        font.family: sb.name
        font.pointSize: 14
    }

    Label {
        id: label4
        x: 181 * parent.width  / 360
        y: 461 * parent.height / 550
        width: 360
        height: 48
        color: "#ffffff"
        text: qsTr("Overall Effectiveness(%)")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: stellar.name
        font.underline: false
        font.pointSize: 22
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectangle
            width: 360
            color: "#de0b27b4"
            z: -1
            anchors.fill: parent
        }
    }

    Label {
        id: label5
        x: 22 * parent.width  / 360
        y: 516 * parent.height / 550
        width: 103
        height: 25
        text: qsTr("Wet Bulb")
        verticalAlignment: Text.AlignVCenter
        font.family: stellar.name
        font.pointSize: 18
    }

    Text {
        id: dewEff
        x: 290 * parent.width  / 360
        y: 517 * parent.height / 550
        text: qsTr("0")
        font.family: voyager.name
        anchors.verticalCenterOffset: 0
        font.pointSize: 16
        anchors.verticalCenter: label6.verticalCenter
    }

    Label {
        id: label6
        x: 191 * parent.width  / 360
        y: 516 * parent.height / 550
        width: 124
        height: 25
        text: qsTr("Dew Point")
        verticalAlignment: Text.AlignVCenter
        font.family: stellar.name
        font.pointSize: 18
    }

    Text {
        id: wbEff
        x: 130 * parent.width  / 360
        y: 521 * parent.height / 550
        text: qsTr("0")
        verticalAlignment: Text.AlignVCenter
        font.family: voyager.name
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: label5.verticalCenter
        font.pointSize: 16
    }


}
























/*##^## Designer {
    D{i:17;anchors_height:200;anchors_width:200;anchors_x:21;anchors_y:8}D{i:21;anchors_x:144}
}
 ##^##*/
