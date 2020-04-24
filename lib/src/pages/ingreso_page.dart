import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class ScanPage extends StatefulWidget {


  @override
  _ScanPageState createState() => new _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String barcode = '';
  var arr = [];
  bool tieneScan = false;
  // String saludo = '';
  // String saludoPalabras = '';
@override
  void initState(){
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    if(!tieneScan){


    return Scaffold(
      appBar: AppBar(
        title: Text('scanner'),
        centerTitle: true,
      ),

      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: RaisedButton(
                    onPressed: scan,
                    // onPressed: () => Navigator.pushReplacementNamed(context, 'admin'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.scanner, size: 40,),
                        SizedBox(width: 10,),
                        Column(
                          children: <Widget>[
                            Text('Enfoque el DNI', style: TextStyle(fontSize: 20),),
                            SizedBox(height: 2,),
                            Text('Click aca para escanear', style: TextStyle(fontSize: 12),)
                          ],
                          ),
                      ],
                    ),
                  ),




                )],
              ),
          ),
Divider(height: 10.0,),
// AQUI COMIENZAN LOS DATOS QUE RESTACO DEL SANNER
Row(children: <Widget>[
                        
                       
                      ]
                    ),
          
            ],
      )
    );



/// SI TIENE VALORES CARGADOS ENTONCES ME LOS MUESTRA
    }else{
        return Scaffold(
              appBar: AppBar(
                title: Text('scanner'),
                centerTitle: true,
              ),

              body: Column(
                children: <Widget>[
                  Container(
                    child: Column(children: <Widget>[

Column(children: <Widget>[
  Row(children: <Widget>[
    Text('DNI ==> ', style: TextStyle(fontSize: 15),) ,Text(arr[4], style: TextStyle(fontSize: 36), ),
    Padding(padding: EdgeInsets.symmetric(horizontal: 12.0),),
                        ],),

  Row(children: <Widget>[
    Text('APELLIDO=>  ', style: TextStyle(fontSize: 15),) ,
    Text(arr[1],style: TextStyle(fontSize: 25), ),
                        ],),

                        ],),

 Row(children: <Widget>[
    Text('NOMBRES=>  ', style: TextStyle(fontSize: 15),) ,
    Text(arr[2],style: TextStyle(fontSize: 25), ),
                        ],),


 Row(children: <Widget>[
    Text('GENERO  =>  ', style: TextStyle(fontSize: 15),) ,
    Text(arr[3],style: TextStyle(fontSize: 25), ),
    Text('       EJEMPLAR  =>  ', style: TextStyle(fontSize: 15),) ,
    Text(arr[5],style: TextStyle(fontSize: 25), ),
                        ],),

 Row(children: <Widget>[
       Text('NACIO EL  =>  ', style: TextStyle(fontSize: 15),) ,
       Text(arr[6],style: TextStyle(fontSize: 25), ),
                        ],),


 Row(children: <Widget>[
       Text('EJEMPLAR EMITIDO =>  ', style: TextStyle(fontSize: 15),) ,
       Text(arr[7],style: TextStyle(fontSize: 25), ),
                        ],
                        ),  
// Row(children: <Widget>[Text(bloc.email)],)                     

                    ],),
                  ),


///botones de dar ok y guardar y de cancelar para salir                  
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  
                  // child: floatingActionButton: buildSpeedDial(),
                  
                ),

                ],

              ),
            );


    }
  }

SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible:true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.exit_to_app, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          label: 'Salir',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.brush, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: 'Entrega',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () => Navigator.pushReplacementNamed(context, 'ingreso'),
          labelWidget: Container(
            color: Colors.blue,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(6),
            child: Text('Ingresar'),
          ),
        ),
      ],
    );
  }


  Future scan() async {

    try{
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        this.arr = barcode.split('@');
          tieneScan = true;
          print (this.arr);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          barcode = "Camera permission was denied";
        });
      } else {
        setState(() {
          barcode = "Error Desconocido $ex";
        });
      }
    } on FormatException {
      setState(() {
        barcode = "Saliste antes de Sacar la foto";
      });
    } catch (ex) {
      setState(() {
        barcode = "Error desconocido $ex";
      });
    }
  }

  void volver() {
    setState(() {
      tieneScan = false;
    });
  }
}