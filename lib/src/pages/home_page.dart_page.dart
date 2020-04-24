import 'package:flutter/material.dart';
import 'package:fote_app/src/bloc/provider.dart';

class HomePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

final bloc = Provider.of(context);
    
    return Scaffold(
       
      appBar: AppBar(
        title: Text('FOTE'),
        backgroundColor: Colors.purple,
       ),
       body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Email: ${ bloc.email }'),
          Text('Password: ${ bloc.password }'),

        ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> {
            
            Navigator.pushReplacementNamed(context, 'login')
          },
          child: Icon(Icons.error),
          backgroundColor: Colors.purple,
        ),      
    );
  }
}