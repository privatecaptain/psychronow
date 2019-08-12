import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtPositioning 5.12


import "coreFunctions.js" as Utils


ApplicationWindow {
    visible: true
    width: sd.width
    height: sd.height
    title: qsTr("PsychroNow")

    property real lat: 0
    property real lon: 0
    visibility: Window.FullScreen
    FontLoader{
        id: ultra
        source: "Ultra.otf"
    }

    FontLoader{
        id: stellar
        source: "Stellar-light.otf"
    }

    FontLoader{
        id: sb
        source: "Stellar-Bold.otf"
    }

    FontLoader{
        id: voyager
        source: "Voyager Grotesque(regular).ttf"
    }
    FontLoader{
        id: vger
        source: "V-GERB(bold).ttf"
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


    Image {
        id: info
        width: 40
        height: 40
        z: 2
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        source: "info.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                infop.visible = true;
            }
        }
    }

    Rectangle {
        id: rectangle
        x: 293
        width: 100
        height: 100
        color: "#ffffff"
        radius: 50
        border.width: 1
        z: 1
        anchors.top: parent.top
        anchors.topMargin: -36
        anchors.right: parent.right
        anchors.rightMargin: -33
    }

    InfoPage{
        id: infop
        width: parent.width
        height: parent.height
        visible: false
        z: 2
    }


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
            id: p1
            width: sd.width
            height: sd.height
            first.unitSwitch.onCheckedChanged: {

                checkUnits();
            }


            function checkUnits(){
                if(first.unitSwitch.checked){
                    first.metric();
                    second.metric();

                }else{
                    first.imperial();
                    second.imperial();
                }
                overall();
            }

            function dpEffect(){
                var db = parseFloat(first.drybulb.real);
                var n  = db - parseFloat(second.db.dreal);
                var d = db - parseFloat(first.dewpoint.real);
                var res = (n/d)*100
                res = res.toFixed(2);
                second.dewEff.text = res;
            }

            function wbEffect(){
                var db = parseFloat(first.drybulb.real);
                var n = db - parseFloat(second.db.dreal);
                var d  = db - parseFloat(first.wetbulb.real);
                var res = (n/d)*100;
                res = res.toFixed(2);
                second.wbEff.text  = res;
            }

            function overall(){
                dpEffect();
                wbEffect();
            }

            property real elev: 0


            PositionSource   {
                id: src
                updateInterval: 1000
                active: true

                onPositionChanged: {
                    var coord = src.position.coordinate;
                    lat = coord.latitude;
                    lon = coord.longitude;
//                    console.log("Coordinate:", coord.longitude, coord.latitude);

                }
            }
        //next button onClick
         nb.onClicked: {

                stackView.push(second);
            first.visible = false;
             second.visible = true;
              nb.visible = false;
                back.visible = true;


         }

         back.onClicked: {
             stackView.pop();
             first.visible = true;
             second.visible = false;
                 back.visible = false;
                 nb.visible = true;


         }



        function firstPageAuto(db,rh,elev){
            db = parseFloat(db);
            rh = parseFloat(rh);
            elev = parseFloat(elev) * 3.281; //Ft
            first.elevation = elev;  //real elevation (Ft)
            var dewp = Utils.dewPoint(db,rh);
            var wb = Utils.wetbulb(db,elev,rh);
            var humrat = Utils.humRat(db,wb,elev);
            var enthalpy = Utils.enthalpyhr(humrat,db);
            var humid = humrat * 7000;
            second.db.dreal = second.db.ireal = first.drybulb.real = db;
            first.elev.text = elev.toFixed(1) + ' Ft.';
            first.wetbulb.real = second.wb.dreal = second.wb.ireal = first.wetbulb.elementText =  wb;
            first.rh.real = second.rh.dreal = second.rh.ireal = first.rh.elementText = rh;
            first.hr.real = second.hr.dreal = second.hr.ireal = first.hr.elementText = humrat.toFixed(4);
            first.enthalpy.real = second.en.dreal = second.en.ireal = first.enthalpy.elementText = enthalpy.toFixed(2);
            first.humidity.real = second.humidity.dreal = second.humidity.ireal = first.humidity.elementText = humid.toFixed(2);
            first.dewpoint.real = second.dewpoint.dreal = second.dewpoint.ireal = first.dewpoint.elementText = dewp;
            checkUnits();
        }

        function getElev(lat,lng,db,rh){
            var elev;
            request('http://34.234.110.20/elev?lat='+lat+'&lon='+lng,function(o){

                       elev = o.responseText;
                        first.loading.running = false;
                       firstPageAuto(db,rh,elev);
                   }

           );
        }

        Component.onCompleted: {
            autoF();
        }

        function autoF() {
            console.warn('test');
            console.info(sd.width);
            console.info(sd.height);

            var lt,lng;
            lt = src.position.coordinate.latitude;
            lng = src.position.coordinate.longitude;
//            lt = toString(lt.toFixed(3));
//            lng = toString(lng.toFixed(3));
            console.info(lt,lng);

            //Busy & Overlay

            first.loading.running = true;

            request('http://api.apixu.com/v1/current.json?key=eca2cc7e249f451b9f1102803191606&q='+lt+','+lng,function (o){
                console.info(o);
                console.info("re");
                var dd = JSON.parse(o.responseText);

                var db = dd.current.temp_f;
                var rh = dd.current.humidity;

                var lat  = dd.location.lat;
                var lon = dd.location.lon;

                first.city.text = dd.location.name + ',' + dd.location.region;
                getElev(lat,lon,db,rh);


            });

        }

        function indirectCooling(){


            var db,rh,dew,wb,hr,en,elev;
            elev = first.elevation;
            db = second.db.ireal = first.drybulb.real - (first.drybulb.real - first.wetbulb.real)*0.8
            dew = second.dewpoint.ireal = first.dewpoint.real
            rh = second.rh.ireal = Utils.rhfromdew(db,dew);
            wb = second.wb.ireal = Utils.wetbulb(db,elev,rh);
            hr = Utils.humRat(db,wb,elev);
            second.hr.ireal = hr.toFixed(4);
            en = Utils.enthalpyhr(hr,db);
            second.en.ireal = en.toFixed(2);
            second.humidity.ireal = (hr*7000).toFixed(2);
            checkUnits();
        }


        function directCoolingON(){
            var DB,RH,WB,HR,EN,dew,elev;

            elev = first.elevation;
            DB = second.db.dreal = second.db.ireal - (second.db.ireal - second.wb.ireal)*0.95;
            WB = second.wb.dreal = second.wb.ireal;

            DB = parseFloat(DB);
            WB = parseFloat(WB);
            HR = Utils.humRat(DB,WB,elev);
            EN = Utils.enthalpyhr(HR,DB);
            RH = Utils.relHum(DB,WB,elev);
            second.rh.dreal = RH.toFixed(2);

            second.dewpoint.dreal = Utils.dewPoint(DB,RH);
            second.hr.dreal = HR.toFixed(4);
            second.en.dreal = EN.toFixed(2);
            second.humidity.dreal = (HR*7000).toFixed(2);
            checkUnits();
        }
        function directCoolingOFF(){
            second.db.dreal = second.db.ireal;
            second.wb.dreal = second.wb.ireal;
            second.rh.dreal = second.rh.ireal;
            second.hr.dreal = second.hr.ireal;
            second.en.dreal = second.en.ireal;
            second.humidity.dreal = second.humidity.ireal;
            second.dewpoint.dreal = second.dewpoint.ireal;
            checkUnits();
        }

        second.indirectSwitch.onCheckedChanged: {
            if(second.indirectSwitch.checked){
              indirectCooling();
                if(second.directSwitch.checked){
                    directCoolingON();
                }else{
                    directCoolingOFF();
                }
             }

            if(second.indirectSwitch.checked === false){
                second.db.ireal = first.drybulb.real;
                second.rh.ireal = first.rh.real;
                second.wb.ireal = first.wetbulb.real;
                second.dewpoint.ireal = first.dewpoint.real;
                second.hr.ireal = first.hr.real;
                second.en.ireal = first.enthalpy.real;
                second.humidity.ireal = first.humidity.real;

                checkUnits();

                if(second.directSwitch.checked){
                    directCoolingON();
                }else{
                    directCoolingOFF();
                }
            }
        }

        second.directSwitch.onCheckedChanged: {
            if(second.directSwitch.checked){

                    directCoolingON();
                }

            if(second.directSwitch.checked === false){

                directCoolingOFF();

            }
        }
}


        Page2Form {
            id: p2
            width: sd.width
            height: sd.height
            first.unitSwitch.onCheckedChanged: {

                checkUnits();
            }

            function dpEffect(){
                var db = parseFloat(first.drybulb.real);
                var n  = db - parseFloat(second.db.dreal);
                var d = db - parseFloat(first.dewpoint.real);
                var res = (n/d)*100
                res = res.toFixed(1);
                second.dewEff.text = res;
            }

            function wbEffect(){
                var db = parseFloat(first.drybulb.real);
                var n = db - parseFloat(second.db.dreal);
                var d  = db - parseFloat(first.wetbulb.real);
                var res = (n/d)*100;
                res = res.toFixed(1);
                second.wbEff.text  = res;
            }

            function overall(){
                dpEffect();
                wbEffect();
            }


            function checkUnits(){
                if(first.unitSwitch.checked){
                    first.metric();
                    second.metric();

                }else{
                    first.imperial();
                    second.imperial();
                }
                overall();
            }


            function indirectCooling(){


                var db,rh,dew,wb,hr,en,elev;
                elev = first.elevation;
                db = second.db.ireal = first.drybulb.real - (first.drybulb.real - first.wetbulb.real)*0.8
                dew = second.dewpoint.ireal = first.dewpoint.real
                rh = second.rh.ireal = Utils.rhfromdew(db,dew);
                wb = second.wb.ireal = Utils.wetbulb(db,elev,rh);
                hr = Utils.humRat(db,wb,elev);
                second.hr.ireal = hr.toFixed(4);
                en = Utils.enthalpyhr(hr,db);
                second.en.ireal = en.toFixed(2);
                second.humidity.ireal = (hr*7000).toFixed(2);
                checkUnits();
            }


            function directCoolingON(){
                var DB,RH,WB,HR,EN,dew,elev;

                elev = first.elevation;
                DB = second.db.dreal = second.db.ireal - (second.db.ireal - second.wb.ireal)*0.95;
                WB = second.wb.dreal = second.wb.ireal;

                DB = parseFloat(DB);
                WB = parseFloat(WB);
                HR = Utils.humRat(DB,WB,elev);
                EN = Utils.enthalpyhr(HR,DB);
                RH = Utils.relHum(DB,WB,elev);
                second.rh.dreal = RH.toFixed(2);

                second.dewpoint.dreal = Utils.dewPoint(DB,RH);
                second.hr.dreal = HR.toFixed(4);
                second.en.dreal = EN.toFixed(2);
                second.humidity.dreal = (HR*7000).toFixed(2);
                checkUnits();
            }
            function directCoolingOFF(){
                second.db.dreal = second.db.ireal;
                second.wb.dreal = second.wb.ireal;
                second.rh.dreal = second.rh.ireal;
                second.hr.dreal = second.hr.ireal;
                second.en.dreal = second.en.ireal;
                second.humidity.dreal = second.humidity.ireal;
                second.dewpoint.dreal = second.dewpoint.ireal;
                checkUnits();
            }

            function firstPageManual(db,rh,elev){
                db = parseFloat(db);
                rh = parseFloat(rh);
                elev = parseFloat(elev) * 3.281; //Ft
                first.elevation = elev;  //real elevation (Ft)
                var dewp = Utils.dewPoint(db,rh);
                var wb = Utils.wetbulb(db,elev,rh);
                var humrat = Utils.humRat(db,wb,elev);
                var enthalpy = Utils.enthalpyhr(humrat,db);
                var humid = humrat * 7000;
                second.db.dreal = second.db.ireal = first.drybulb.real = db;
                first.elev.text = elev.toFixed(1) + ' Ft.';
                first.wetbulb.real = second.wb.dreal = second.wb.ireal = first.wetbulb.elementText =  wb;
                first.rh.real = second.rh.dreal = second.rh.ireal = first.rh.elementText = rh;
                first.hr.real = second.hr.dreal = second.hr.ireal = first.hr.elementText = humrat.toFixed(4);
                first.enthalpy.real = second.en.dreal = second.en.ireal = first.enthalpy.elementText = enthalpy.toFixed(1);
                first.humidity.real = second.humidity.dreal = second.humidity.ireal = first.humidity.elementText = humid.toFixed(1);
                first.dewpoint.real = second.dewpoint.dreal = second.dewpoint.ireal = first.dewpoint.elementText = dewp;
                checkUnits();
            }

            function getElev(lat,lng,db,rh){
                var elev;
                request('http://34.234.110.20/elev?lat='+lat+'&lon='+lng,function(o){

                           elev = o.responseText;
                            first.loading.running = false;
                           firstPageManual(db,rh,elev);
                       }

               );
            }

            location.loca.onTextEdited: {


//                            console.info(location.loca.text);
//
            }

            function searchShit(loc){
                location.busyIndicator.running = true;

                request('http://api.apixu.com/v1/current.json?key=eca2cc7e249f451b9f1102803191606&q='+loc,function (o){
                    console.info(o);
                    console.info("re");
                    var dd = JSON.parse(o.responseText);
                    var db = dd.current.temp_f;
                    var rh = dd.current.humidity;
                    db = parseFloat(db);
                    rh = parseFloat(rh);
//                    var dewp = Utils.dewPoint(db,rh);
//                    var wb = Utils.wetbulb(db,elev,rh);
//                    var humrat = Utils.humRat(db,wb,elev);
//                    var enthalpy = Utils.enthalpyhr(humrat,db);
//                    var humid = humrat * 7000;
//                    first.drybulb.elementText = db;
//                    first.rh.elementText = rh;
//                    first.dewpoint.elementText = dewp;
//                    first.wetbulb.elementText =  wb;
//                    first.hr.elementText = humrat.toFixed(4);
//                    first.enthalpy.elementText = enthalpy.toFixed(2);
//                    first.humidity.elementText = humid.toFixed(2);
                    var lat  = dd.location.lat;
                    var lon = dd.location.lon;

                    first.city.text = dd.location.name + ',' + dd.location.region;
                    getElev(lat,lon,db,rh);


                    location.busyIndicator.running = false;

                    //Next Page
                    locaView.push(first);
                    location.visible = false;
                    first.visible = true;
                    next.visible = true;
                    back.visible = true;
                });

            }

            location.search.onClicked: {
                searchShit(location.loca.text);
            }

            location.toronto.onClicked: {searchShit("Toronto")}
            location.paris.onClicked: {searchShit("Paris")}
            location.la.onClicked: {searchShit("Los Angeles")}
            location.tokyo.onClicked: {searchShit("Tokyo")}
            location.beijing.onClicked: {searchShit("beijing")}
            location.phoenix.onClicked: {searchShit("Phoenix")}
            location.dubai.onClicked: {searchShit("Dubai")}
            location.london.onClicked: {searchShit("London")}
            location.nyc.onClicked: {searchShit("New York City")}

            second.indirectSwitch.onCheckedChanged: {
                if(second.indirectSwitch.checked){
                  indirectCooling();
                    if(second.directSwitch.checked){
                        directCoolingON();
                    }else{
                        directCoolingOFF();
                    }
                 }

                if(second.indirectSwitch.checked === false){
                    second.db.ireal = first.drybulb.real;
                    second.rh.ireal = first.rh.real;
                    second.wb.ireal = first.wetbulb.real;
                    second.dewpoint.ireal = first.dewpoint.real;
                    second.hr.ireal = first.hr.real;
                    second.en.ireal = first.enthalpy.real;
                    second.humidity.ireal = first.humidity.real;

                    checkUnits();

                    if(second.directSwitch.checked){
                        directCoolingON();
                    }else{
                        directCoolingOFF();
                    }
                }
            }

            second.directSwitch.onCheckedChanged: {
                if(second.directSwitch.checked){

                        directCoolingON();
                    }

                if(second.directSwitch.checked === false){

                    directCoolingOFF();

                }
            }


            next.onClicked: {
                locaView.push(second);
                first.visible = false;
                second.visible = true;
                next.visible = false;


            }

            back.onClicked: {
                locaView.pop();
                if(locaView.currentItem === first){

                first.visible = true;
                second.visible = false;
                next.visible = true;

                }
                else{
                    first.visible = false;
                    location.visible = true;
                    back.visible = false;
                    next.visible = false;
                    second.indirectSwitch.checked = false;
                    second.directSwitch.checked = false;
                    location.loca.clear();

                }

            }
        }

        Page3Form{
            id: p3
            width: sd.width
            height: sd.height
            function dpEffect(){
                var db = parseFloat(manual.db.real);
                var n  = db - parseFloat(second.db.dreal);
                var d = db - parseFloat(manual.dewpoint.real);
                var res = (n/d)*100
                res = res.toFixed(1);
                second.dewEff.text = res;
            }

            function wbEffect(){
                var db = parseFloat(manual.db.real);
                var n = db - parseFloat(second.db.dreal);
                var d  = db - parseFloat(manual.wb.real);
                var res = (n/d)*100;
                res = res.toFixed(1);
                second.wbEff.text  = res;
            }

            function overall(){
                dpEffect();
                wbEffect();
            }

            function indirectCooling(){


                var db,rh,dew,wb,hr,en,elev;
                elev = manual.elevation;
                db = second.db.ireal = manual.db.real - (manual.db.real - manual.wb.real)*0.8
                dew = second.dewpoint.ireal = manual.dewpoint.real
                rh = second.rh.ireal = Utils.rhfromdew(db,dew);
                wb = second.wb.ireal = Utils.wetbulb(db,elev,rh);
                hr = Utils.humRat(db,wb,elev);
                second.hr.ireal = hr.toFixed(4);
                en = Utils.enthalpyhr(hr,db);
                second.en.ireal = en.toFixed(1);
                second.humidity.ireal = (hr*7000).toFixed(1);
                checkUnits();
            }


            function directCoolingON(){
                var DB,RH,WB,HR,EN,dew,elev;

                elev = manual.elevation;
                DB = second.db.dreal = second.db.ireal - (second.db.ireal - second.wb.ireal)*0.95;
                WB = second.wb.dreal = second.wb.ireal;

                DB = parseFloat(DB);
                WB = parseFloat(WB);
                HR = Utils.humRat(DB,WB,elev);
                EN = Utils.enthalpyhr(HR,DB);
                RH = Utils.relHum(DB,WB,elev);
                second.rh.dreal = RH.toFixed(1);

                second.dewpoint.dreal = Utils.dewPoint(DB,RH);
                second.hr.dreal = HR.toFixed(4);
                second.en.dreal = EN.toFixed(1);
                second.humidity.dreal = (HR*7000).toFixed(1);
                checkUnits();
            }
            function directCoolingOFF(){
                second.db.dreal = second.db.ireal;
                second.wb.dreal = second.wb.ireal;
                second.rh.dreal = second.rh.ireal;
                second.hr.dreal = second.hr.ireal;
                second.en.dreal = second.en.ireal;
                second.humidity.dreal = second.humidity.ireal;
                second.dewpoint.dreal = second.dewpoint.ireal;
                checkUnits();
            }

            second.indirectSwitch.onCheckedChanged: {
                if(second.indirectSwitch.checked){
                  indirectCooling();
                    if(second.directSwitch.checked){
                        directCoolingON();
                    }else{
                        directCoolingOFF();
                    }
                 }

                if(second.indirectSwitch.checked === false){
                    second.db.ireal = manual.db.real;
                    second.rh.ireal = manual.rh.real;
                    second.wb.ireal = manual.wb.real;
                    second.dewpoint.ireal = manual.dewpoint.real;
                    second.hr.ireal = manual.hr.real;
                    second.en.ireal = manual.en.real;
                    second.humidity.ireal = manual.humidity.real;

                    checkUnits();

                    if(second.directSwitch.checked){
                        directCoolingON();
                    }else{
                        directCoolingOFF();
                    }
                }
            }

            second.directSwitch.onCheckedChanged: {
                if(second.directSwitch.checked){

                        directCoolingON();
                    }

                if(second.directSwitch.checked === false){

                    directCoolingOFF();

                }
            }


            clearBtn.onClicked:{
                clear();
            }

//            Navigation
            next.onClicked: {
                manualView.push(second);
                manual.visible = false;
                second.visible = true;
                back.visible = true;
                next.visible = false;
                manualButton.visible = false;
                clearBtn.visible = false;
            }

            back.onClicked: {
                manualView.pop();
                second.visible = false;
                manual.visible = true;
                back.visible = false;
                next.visible = true;
                manualButton.visible = true;
                clearBtn.visible = true;

            }


            function checkUnits(){
                if(manual.unitSwitch.checked){
                    manual.metric(dodo,kaka);
                    second.metric();
                }else{
                    second.imperial();
                }
                overall();
            }
            property bool dodo: true
            property bool kaka: true
            function firstPageManual(db,elev,rh,metric){
                console.info('fpm');
                db = parseFloat(db);
                rh = parseFloat(rh);
                if(metric){
                    elev = parseFloat(elev) * 3.281; //Ft
                    manual.elevation = elev;
                    db = db*(9/5) + 32;
                }

                var dewp = Utils.dewPoint(db,rh);
                var wb = Utils.wetbulb(db,elev,rh);
                var humrat = Utils.humRat(db,wb,elev);
                var enthalpy = Utils.enthalpyhr(humrat,db);
                var humid = humrat * 7000;

                if(manual.rh.textField.acceptableInput === false){
                    manual.rh.textField.text = rh.toFixed(0);
                }

                manual.db.real = second.db.dreal = second.db.ireal = db;
                manual.wb.real = second.wb.dreal = second.wb.ireal  = wb;
                manual.rh.real = second.rh.dreal = second.rh.ireal  = rh;
                manual.hr.real = second.hr.dreal = second.hr.ireal = manual.hr.elementText = humrat.toFixed(4);
                manual.en.real = second.en.dreal = second.en.ireal = manual.en.elementText = enthalpy.toFixed(1);
                manual.humidity.real = second.humidity.dreal = second.humidity.ireal = manual.humidity.elementText = humid.toFixed(1);
                manual.dewpoint.real = second.dewpoint.dreal = second.dewpoint.ireal = dewp;

                if(kaka){//not using dewpoint
                    manual.dewpoint.textField.text = dewp;
                }

                if(dodo){ //not using wetbulb
                    manual.wb.textField.text = wb;
                }

                checkUnits();
                next.visible = true;
            }

            function clear(){

                manual.db.textField.text = "";
                manual.rh.textField.text = "";
                manual.wb.textField.text = "";
                manual.dewpoint.textField.text = "";
                manual.elev.textField.text = "";
                manual.hr.elementText = "";
                manual.en.elementText = "";
                manual.humidity.elementText = "";
                next.visible = false;
            }

            manual.unitSwitch.onCheckedChanged: {
                console.info('clear');
                clear();
                if(manual.unitSwitch.checked){
                    manual.metricLabel();

                }else{
                    manual.imperialLabel();
                }


            }

            manualButton.onClicked:{

                var metric = manual.unitSwitch.checked;
                dodo = kaka = true;
                if(manual.db.textField.acceptableInput && manual.elev.textField.acceptableInput){
//                    manual.en.elementText = 10;
                    manual.w1.text = "";
                    manual.w2.text = "";
                    manual.w3.text = "";
                    if(manual.rh.textField.acceptableInput || manual.wb.textField.acceptableInput || manual.dewpoint.textField.acceptableInput){
                        //ALL GOOD
                        var db  = manual.db.textField.text;
                        db = parseFloat(db);
                        var elev = manual.elev.textField.text;
                        if(manual.rh.textField.acceptableInput){
                            firstPageManual(db,elev,manual.rh.textField.text,metric)
                            console.info('From RH');
                        }

                        else if(manual.dewpoint.textField.acceptableInput){
                            //check if dew <= wetbulb

                            console.info("FROM DEWPOUIN");
                            var dew = manual.dewpoint.textField.text;
                            dew = parseFloat(dew);
                            if(dew <= db){//ok
                                var rh;
                                if(metric){
                                    var dd ,dede;
                                    dd = db*(9/5) + 32;
                                    dede = dew*(9/5) + 32;
                                    rh = Utils.rhfromdew(dd,dede);
                                }else{
                                    rh = Utils.rhfromdew(db,dew);
                                }
                                kaka = false;
                                firstPageManual(db,elev,rh,metric);
                            }else{//warn
                                manual.w3.text = "Dewpoint should be <= " + db;
                            }
                        }else{
                            //check if wetbulb <= drybulb

                            console.info("FROM WETBULB");
                            var wb = manual.wb.textField.text;
                            wb = parseFloat(wb);
                            if(wb <= db){ //ok
                                var r;
                                elev = parseFloat(elev);
                                if(metric){
                                    var e  = parseFloat(elev) * 3.281; //Ft
                                    var d = db*(9/5) + 32;
                                    var w = wb*(9/5) + 32;
                                    r = Utils.relHum(d,w,e)
                                }else{
                                    r = Utils.relHum(db,wb,elev);

                                }
                                dodo = false;
                                firstPageManual(db,elev,r,metric);
                            }else{//warn
                                manual.w3.text = "Wetbulb should be <= " + db;
                            }
                        }

                    }
                }else{
                    manual.db.textField.placeholderText =  "required";
                    manual.elev.textField.placeholderText =  "required";
                    if(!manual.db.textField.acceptableInput){
                        manual.w1.text = "Required: Dry Bulb";
                    }
                    if(!manual.elev.textField.acceptableInput){
                        manual.w2.text = "Required: Elevation";
                    }
                    manual.w3.text = "Required: RH or WetBulb or DewPoint"

                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex


        TabButton {
            text: qsTr("Auto")
            onClicked: {
                swipeView.currentIndex = 0;
                p1.stackView.pop(null);
                p1.back.visible = false;
                p1.nb.visible = true;
                p1.autoF();
//                p1.first.reset();
            }
        }
        TabButton {
            text: qsTr("Location")
            onClicked: {
                swipeView.currentIndex = 1;

                    p2.locaView.pop(null);
                    p2.back.visible = false;
                    p2.next.visible = false;;
                    p2.location.visible = true;
                    p2.location.loca.clear();

            }
        }

        TabButton {
            text: qsTr("Manual")
            onClicked: {
                swipeView.currentIndex = 2;
                p3.manualView.pop(null);
                p3.manual.visible = true;
                p3.back.visible = false;
                p3.next.visible = true;
                p3.manualButton.visible = true;
                p3.clearBtn.visible = true;
                p3.clear();
            }
        }
    }
}
