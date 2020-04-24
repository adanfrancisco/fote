import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fote_app/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
final bloc = Provider.of(context);

    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
      
    );
  }

  Widget _loginForm(context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

  
    return SingleChildScrollView(

      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius:  3.0
                )
              ]
            ),
          child: Column(
            children: <Widget>[
              Text('ingreso', style: TextStyle( fontSize: 20.0 ), ),
              SizedBox( height: 50.0, ),
              _crearEmail( bloc ),
              SizedBox( height: 30.0, ),
              _crearPasword( bloc ),
              SizedBox( height: 30.0, ),
              _crearBoton( bloc ),
            ],
          ),
            ),
            Text('¿Olvido la contraseña?'),
            SizedBox( height: 100.0, )

        ],
      ),
      

    );
  }
  
  
    Widget _crearEmail(LoginBloc bloc) {

      return StreamBuilder(
        stream: bloc.emailStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.deepPurple),
            hintText: 'micorreo@correo.com',
            labelText: 'Correo Electronico',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged:  bloc.changeEmail,
        ),
      
      );
        },
      );
   }


    Widget _crearPasword(LoginBloc bloc) {

      return StreamBuilder(
        stream: bloc.passwordStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error

            ),
            onChanged: bloc.changePassword
          ),
        );
        
        },
      );
    }


    Widget _crearBoton(LoginBloc bloc) {

      return StreamBuilder(
        stream: bloc.formValidStream ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          
        return RaisedButton(
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0 ) ,

                  child: Text('Ingresar'),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  elevation: 0.0, // sin sombras
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: snapshot.hasData ? ()=>_login(bloc, context) : null
              );


        },
      );
    }


/* _login(LoginBloc bloc, BuildContext context) {

  print('================');
  print('Email: ${ bloc.email }');
  print('Passwords: ${ bloc.password }');
  print('================');


  //Navigator.pushReplacementNamed(context, 'home');
} */
String msg='';

Future<List> _login(LoginBloc bloc, BuildContext context) async {
  final response = await http.post("http://fote.aloeadan.com/getuser.php", body: {
    "usuario": bloc.email,
    "contrasena": bloc.password,
  });

  var datauser = json.decode(response.body);

  if(datauser.length==0){
    Fluttertoast.showToast(
        msg: "Ese usuario no fue encontrado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return null;
  }else{
    if(datauser[0]['role']=='1'){
       Navigator.pushReplacementNamed(context, 'admin');
    }else if(datauser[0]['role']=='2'){
      Navigator.pushReplacementNamed(context, '/MemberPage');
    }

  }

  return datauser;
}

      
  
  
  
  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(63, 63, 156, 1.0),
              Color.fromRGBO(90, 70, 178, 1.0),
            ]
            ),
        ),
    );

final circulo = Container(
  width: 100.0,height: 100.0,
  decoration: BoxDecoration(
    borderRadius:  BorderRadius.circular(100.0),
    color: Color.fromRGBO(255, 255, 255, 0.05)
  ),
);

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0,left: 30.0, child: circulo),
        Positioned(top: -40.0,right: -30.0, child: circulo),
        Positioned(top: -70.0,right: -10.0, child: circulo),
        Positioned(bottom: 120.0,right: 20.0, child: circulo),
        Positioned(bottom: -50.0,left: -20.0, child: circulo),

        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon( Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox( height: 10.0, width: double.infinity,),
              Text('Fote', style: TextStyle( color: Colors.white, fontSize: 25.0 ),)
            ],
          ),


        ),
      ],
    );
  }





}