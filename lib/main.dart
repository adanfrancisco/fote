import 'package:flutter/material.dart';
import 'package:fote_app/src/pages/admin_user_page.dart';
import 'package:fote_app/src/pages/ingreso_page.dart';
import 'src/bloc/provider.dart';


import 'src/pages/login_page.dart_page.dart';
import 'src/pages/home_page.dart_page.dart';
import 'src/pages/busqueda_page.dart';
import 'src/pages/retiro_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'admin',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => HomePage(),
        'busqueda' :(BuildContext context) => List2(),
        'retiro': (BuildContext context) =>  ListaPage(),
        'admin': (BuildContext context) =>  AdminPage(),
        'ingreso': (BuildContext context) =>  ScanPage(),
      },
      
    ),
    );
    
    
    
    
    

  }
}