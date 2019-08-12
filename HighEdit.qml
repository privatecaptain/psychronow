import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQml 2.12

Item {
    id: element1
    width: 320
    height: 40
    property alias textField: textField
    property alias labelText: label.text
    property real real: 0


        Label {
            id: label
            width: 155
            height: 36
            color: "#de0b27b4"
            text: qsTr("Dew Point ")
            font.pointSize: 20
            horizontalAlignment: Text.AlignLeft
            fontSizeMode: Text.FixedSize
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillHeight: true
            Layout.leftMargin: 10
            wrapMode: Text.NoWrap
            font.family: sb.name
            verticalAlignment: Text.AlignVCenter
        }

        TextField {
            id: textField
            width: 120
            height: 30
            text: "34"
            rightPadding: 20
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            bottomPadding: 0
            topPadding: 0
            horizontalAlignment: Text.AlignRight
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: DoubleValidator{}
            font.family: voyager.name



        }

        function neg(){
            if(textField.text < 0){
                textField.text = textField.text.replace('-','');
            }else if(textField.text !== '-'){
                textField.text  = '-' + textField.text
            }else{
                textField.text = ''
            }
        }


    }
