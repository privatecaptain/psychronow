import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    width: 360
    height: 500
    property alias listView: listView
    property alias loca: loca
    property alias search: search
    property alias busyIndicator: busyIndicator

    Image {
        id: image1
        y: 8
        width: 64
        height: 64
        anchors.left: parent.left
        anchors.leftMargin: 56
        fillMode: Image.PreserveAspectFit
        source: "map (1).png"
    }

    Label {
        id: label
        y: 25
        text: qsTr("SELECT LOCATION")
        font.family: sb.name
        anchors.left: image1.right
        anchors.leftMargin: 15
        anchors.verticalCenter: image1.verticalCenter
        font.pointSize: 17
    }

    TextField {
        id: loca
        x: 63
        y: 107
        width: 247
        height: 65
        z: 1
        verticalAlignment: Text.AlignBottom

        placeholderText: qsTr("City Name")
        font.pointSize: 21
        anchors.horizontalCenterOffset: 1
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        inputMethodHints: Qt.ImhNoPredictiveText



        onDisplayTextChanged:  {
            console.info(text);
            listView.visible = true;
            request('http://34.234.110.20/autocomplete?txt='+location.loca.displayText,function(o){

                console.info(o.responseText)
               var data = JSON.parse(o.responseText)
               data = data.predictions
              console.info(data);
                predictions.clear();
               for(var k in data){
                     console.info(data[k])
                    predictions.append({'cityName': data[k]});

                       }


                    });
        }
    }

    ListView {
        id: listView
        x: 57
        y: 165
        width: 247
        height: 160
        z: 1
        visible: true

        delegate:
            Item {
                id: element
                width: 247
                height: 36

                Rectangle {
                    id: rectangle
                    color: "#ffffff"
                    border.color: "#e6e6e6"
                    border.width: 1
                    anchors.fill: parent

                    Text {
                        id: city
                        x: 36
                        y: 2
                        width: 200
                        height: 32
                        text: cityName
//                        font.family: stellar.name
                        verticalAlignment: Text.AlignVCenter
                        clip: true
                        font.pixelSize: 20
                    }
                }

                Image {
                    id: image
                    x: 0
                    y: 6
                    width: 24
                    anchors.verticalCenter: parent.verticalCenter
                    source: "pin.png"
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        loca.text = city.text
                        listView.visible = false;
                    }
                }

            }



        model: ListModel {
            id: predictions


        }
    }
    function request(url, callback) {
           var xhr = new XMLHttpRequest();
           xhr.onreadystatechange = (function(myxhr) {
               return function() {
                   if(myxhr.readyState === XMLHttpRequest.DONE)callback(myxhr);
               }
           })(xhr);
           xhr.open('GET', url, true);
           xhr.send();
       }



    Label {
        id: label1
        x: 163
        y: 231
        color: "#de0b27b4"
        text: qsTr("Most Popular")
        font.italic: true
        font.family: stellar.name
        font.underline: false
        font.pointSize: 19
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Grid {
        id: grid
        x: 15
        y: 284
        width: 332
        height: 198
    }

    Button {
        id: search
        x: 144
        y: 178
        width: 72
        height: 36
        text: qsTr("SELECT")
    }
    BusyIndicator {
        id: busyIndicator
        x: 12
        y: 7
        anchors.verticalCenterOffset: -163
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: false
    }

}







