import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
Item {
    id: element1
    width: 320
    height: 40
    property alias textField: textField
    property alias labelText: label.text
    property alias neg: image.visible
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
            rightPadding: 10
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            bottomPadding: 0
            topPadding: 0
            horizontalAlignment: Text.AlignRight
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: DoubleValidator{}
            font.family: voyager.name




        }
        function serialize(object, maxDepth) {
            function _processObject(object, maxDepth, level) {
                var output = new Array()
                var pad = "  "
                if (maxDepth === undefined) {
                    maxDepth = -1
                }
                if (level === undefined) {
                    level = 0
                }
                var padding = new Array(level + 1).join(pad)

                output.push((Array.isArray(object) ? "[" : "{"))
                var fields = new Array()
                for (var key in object) {
                    var keyText = Array.isArray(object) ? "" : ("\"" + key + "\": ")
                    if (typeof (object[key]) == "object" && key !== "parent" && maxDepth !== 0) {
                        var res = _processObject(object[key], maxDepth > 0 ? maxDepth - 1 : -1, level + 1)
                        fields.push(padding + pad + keyText + res)
                    } else {
                        fields.push(padding + pad + keyText + "\"" + object[key] + "\"")
                    }
                }
                output.push(fields.join(",\n"))
                output.push(padding + (Array.isArray(object) ? "]" : "}"))

                return output.join("\n")
            }

            return _processObject(object, maxDepth)
        }
        Image {
            id: image
            x: 306
            y: 0
            width: 20
            height: 20
            anchors.verticalCenterOffset: -2
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 0
            fillMode: Image.PreserveAspectFit
            source: "negative.png"
            visible: true
            MouseArea{
                anchors.fill: parent
                onClicked: {

                    var cr = textField.implicitHeight;
                    var cur = textField.cursorRectangle;

                    if(parent.source == "qrc:/negative.png"){
                        textField.text = "-" + textField.text;
                        parent.source = "qrc:/plus.png";

                            textField.children.top = 0;
                            textField.top = 0;
//                        textField.implicitHeight = cr;
//                        console.log(serialize(textField,1))

                    }else{
                        textField.text = textField.text.replace("-","")
                        parent.source = "qrc:/negative.png";

                    }
                }
            }
        }


    }
