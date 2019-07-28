function dryfromhr(hr, wb, ElevInFt){
//   #Wet bulb in Degree Rankin
    RT = wb + 459.67
//    #Atmos. Pressure in psia
    pt = 14.696 *  ( 1 - 0.0000068753 * ElevInFt )  ** 5.2559
    c8 = - 10440.4
    c9 = - 11.29465
    c10 = - 0.027022355
    c11 = 0.00001289036
    c12 = - 0.000000002478068
    c13 = 6.5459673
    pws = Math.exp(c8 / RT + c9 + c10 * RT + c11 * RT ** 2 + c12 * RT ** 3 + c13 * Math.log(RT))
    wsat = ( pws * 0.62198 )  /  ( pt - pws )
    a1 = ( 1093 - 0.556 * wb )  * wsat
    a2 = 1093 - wb
    a3 = hr * 0.444
    db = ( a1 - hr * a2 + 0.24 * wb )  /  ( 0.24 + a3 )
    fn_return_value = db
    return fn_return_value

}



function wetbulb(db, elev, Rh){
    var C1 = 6.112
    var c2 = 17.67
    var c3 = 243.5
    var c4 = 0.00066
    var c5 = 0.000000759
    var e = 2.71828
//    DEW = ( DEW - 32 )  * 5 / 9
    db = ( db - 32 )  * 5 / 9
    var ASUM2 = db
    var wb = ASUM2
    var pt = ( 14.696 *  ( 1 - 0.0000068753 * elev )  ** 5.2559 )  * 68.9476
    var es = C1 * e **  ( ( c2 * db )  /  ( db + c3 ) )
    var et1 = es * Rh / 100
    var et = et1
    while(1){
        var z1 = C1 * e **  ( ( c2 * wb )  /  ( wb + c3 ) )
        var z2 = pt *  ( c4 +  ( c5 * wb ) )  *  ( db - wb )
        var z3 = z1 - z2
        var Z = z3
        wb = wb - 1
        if (Z < et)
            break
    }
    while(1){
        var y1 = C1 * e **  ( ( c2 * wb )  /  ( wb + c3 ) )
        var y2 = pt *  ( c4 +  ( c5 * wb ) )  *  ( db - wb )
       var  y3 = y1 - y2
        var y = y3
        wb = wb + 0.01
        if (y >= et)
            break
    }
    wb = ( wb * 9 / 5 )  + 32
    wb = Math.round(wb, 8)
    return wb

}



function dewPoint(db, Rh){

    var es = 6.11 * 10 **  ( ( 7.5 *  ( ( db - 32 )  * 5 / 9 ) )  /  ( 237.7 +  ( ( db - 32 )  * 5 / 9 ) ) );
    var x = Math.log(es * Rh / 611);
    var y = Math.log(10);
    var Z = x / y;
    var dw = ( 237.7 * Z )  /  ( 7.5 - Z );
    dw = ( dw * 9 / 5 )  + 32;
    dw = Math.round(dw,3);
    return dw

}



function rhfromdew(db, DEW){
    var es = 6.11 * 10 **  ( ( 7.5 *  ( ( db - 32 )  * 5 / 9 ) )  /  ( 237.7 +  ( ( db - 32 )  * 5 / 9 ) ) )
    DEW = ( DEW - 32 )  * 5 / 9
    var fn_return_value = ( 10 **  ( ( DEW * 7.5 )  /  ( 237.7 + DEW ) ) )  * 611 / es
    return fn_return_value.toFixed(2)

}
function elevFrompsia(pt){
    pt = pt / 68.948;
    var elev = (1 - (pt/14.696) ** (1/5.2559))/0.0000068753
    return elev;
}

function relHum(db, wb, ElevInFt){
//    #Wet bulb in Degree Rankin
    var RT = wb + 459.67
//    #Atmos. Pressure in psia
    var pt = 14.696 *  ( 1 - 0.0000068753 * ElevInFt )  ** 5.2559
    var c8 = - 10440.4
    var c9 = - 11.29465
    var c10 = - 0.027022355
    var c11 = 0.00001289036
    var c12 = - 0.000000002478068
    var c13 = 6.5459673
    var pws = Math.exp(c8 / RT + c9 + c10 * RT + c11 * RT ** 2 + c12 * RT ** 3 + c13 * Math.log(RT))
    var wsat = ( pws * 0.62198 )  /  ( pt - pws )
    var wnom = ( 1093 - 0.556 * wb )  * wsat - 0.24 *  ( db - wb )
    var wdenom = 1093 + 0.444 * db - wb
    var W = wnom / wdenom
    var pw = ( W * pt )  /  ( 0.62198 + W )
    RT = db + 459.67
    var ps = Math.exp(c8 / RT + c9 + c10 * RT + c11 * RT ** 2 + c12 * RT ** 3 + c13 * Math.log(RT))
    var pa = pt - pw
    var fn_return_value = 100 *  ( W * pa )  /  ( 0.62198 * ps )
    return fn_return_value
}


function humRat(db, wb, ElevInFt){
//    #Wet bulb in Degree Rankin
    var RT = wb + 459.67
//    #Atmos. Pressure in psia
   var  pt = 14.696 *  ( 1 - 0.0000068753 * ElevInFt )  ** 5.2559
   var  c8 = - 10440.4
    var c9 = - 11.29465
   var c10 = - 0.027022355
   var c11 = 0.00001289036
   var c12 = - 0.000000002478068
   var c13 = 6.5459673
   var pws = Math.exp(c8 / RT + c9 + c10 * RT + c11 * RT ** 2 + c12 * RT ** 3 + c13 * Math.log(RT))
   var wsat = ( pws * 0.62198 )  /  ( pt - pws )
   var wnom = ( 1093 - 0.556 * wb )  * wsat - 0.24 *  ( db - wb )
   var wdenom = 1093 + 0.444 * db - wb
    var fn_return_value = wnom / wdenom
    return fn_return_value
}


function st(hr, elev, stemp, eh){
    e1 = 0.24 * stemp + hr *  ( 1061 + 0.444 * stemp )
    while (!(e1 <= eh)){
        stemp = stemp - 0.001
        hr =  new HumRat(stemp, stemp, elev)
        e1 = 0.24 * stemp + hr *  ( 1061 + 0.444 * stemp )
    }
    fn_return_value = Math.round(stemp, 3)
    return fn_return_value
}


function dewPointAl(elev, hr){
//    #
//    # DewPoint Macro
//    # Macro recorded 9/23/2003 by Skavanaugh
//    #
    var p,pw,alpha,C14,C15,C16,C17,C18,fn_return_value;
    p = 14.696 *  ( 1 - 0.0000068753 * elev )  ** 5.2559
    pw = ( p * hr )  /  ( 0.62198 + hr )
    alpha = Math.log(pw)
    C14 = 100.45
    C15 = 33.193
    C16 = 2.319
    C17 = 0.17074
    C18 = 1.2063
    fn_return_value = C14 + C15 * alpha + C16 * alpha ** 2 + C17 * alpha ** 3 + C18 *  ( pw )  ** 0.1984
    return fn_return_value
}

function enthalpyhr(hr,db){
    var Fen = (0.24 * db) + (hr * (1061 + 0.444 * db))
    return Fen
}
