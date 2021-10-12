import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lsu_app/widgets/BarraDeNavegacion.dart';

class Noticias extends StatefulWidget {
  const Noticias({key}) : super(key: key);

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Form(key: formKey, child: enConstruccion(context))));
  }

  enConstruccion(context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
          BarraDeNavegacion(
          titulo: Text('BIBLIOTECA',
              style: TextStyle(fontFamily: 'Trueno', fontSize: 14)),
    ),
    SizedBox(height: 30),
    Image(
    image: AssetImage('recursos/EnConstruccion.png'),
    )
    ],
    )
    ,
    )
    ,
    );
  }
}
