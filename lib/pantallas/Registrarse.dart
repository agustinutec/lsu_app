import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lsu_app/manejadores/Colores.dart';
import 'package:lsu_app/manejadores/Navegacion.dart';
import 'package:lsu_app/manejadores/Validar.dart';
import 'package:lsu_app/servicios/AuthService.dart';
import 'package:lsu_app/servicios/ErrorHandler.dart';
import 'package:lsu_app/widgets/BarraDeNavegacion.dart';
import 'package:lsu_app/widgets/Boton.dart';
import 'package:lsu_app/widgets/TextFieldContrasenia.dart';
import 'package:lsu_app/widgets/TextFieldNumerico.dart';
import 'package:lsu_app/widgets/TextFieldTexto.dart';

class Registrarse extends StatefulWidget {
  @override
  _RegistrarseState createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _nombreCompleto;
  String _telefono;
  String _localidad;
  String _especialidad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: formularioRegistro(context)
          )
        )
    );
  }

  formularioRegistro(context) {
    return Scaffold(
        body:
          SingleChildScrollView(
            child: Column(children: [
              BarraDeNavegacion(
                titulo: 'REGISTRARSE',
                iconoBtnUno: null,
                onPressedBtnUno: null,
              ),

              SizedBox(height: 30.0),

              //CORREO
              TextFieldTexto(
                nombre: 'CORREO',
                icon: Icon(Icons.alternate_email_rounded),
                valor: (value) {
                  this._email = value;
                },

                validacion: (value) => value.isEmpty
                  ? 'Campo obligatorio'
                  : Validar().validarCorreo(value)
              ),

              // CONTRASEÑA
              TextFieldContrasenia(
                nombre: 'CONTRASEÑA',
                icon: Icon(Icons.lock_outline),
                valor: (value) {
                  this._password = value;
                },

                validacion: (value) => value.isEmpty
                  ? 'Campo obligatorio'
                  : Validar().validarPassword(value)  
              ),

              // NOMBRE COMPLETO
              TextFieldTexto(
                nombre: 'NOMBRE COMPLETO',
                icon: Icon(Icons.person),
                valor: (value) {
                  this._nombreCompleto = value.toUpperCase();
                },
                validacion: ((value) =>
                  value.isEmpty ? 'Campo obligatorio' : null)),

              // CELULAR
              TextFieldNumerico(
                nombre: 'CELULAR',
                icon: Icon(Icons.phone),
                valor: (value) {
                  this._telefono = value;
                },

                validacion: (value)  => value.isEmpty
                  ? 'Campo obligatorio'
                  : Validar().validarCelular(value)
              ),

              // LOCALIDAD
              TextFieldTexto(
                nombre: 'LOCALIDAD',
                icon: Icon(Icons.location_city_outlined),
                valor: (value) {
                  this._localidad = value.toUpperCase();
                },
                validacion: ((value) =>
                  value.isEmpty ? 'Campo obligatorio' : null)),

              // ESPECIALIDAD
              TextFieldTexto(
                  nombre: 'ESPECIALIDAD',
                  icon: Icon(Icons.military_tech_outlined),
                  valor: (value) {
                    this._especialidad = value.toUpperCase();
                  },
                  validacion: ((value) =>
                      value.isEmpty ? 'Campo obligatorio' : null)),
              SizedBox(height: 50.0),

              Boton(

                titulo: 'REGISTRARSE',

                onTap: () {

                  String _statusUsuario = 'pendiente';

                  if (Validar().camposVacios(formKey)) {

                    AuthService()

                    //dejo mi UID vacia ya que la obtengo en mi manejador luego de hacer el create user.

                        .signUp('', _email, _password, _nombreCompleto, _telefono,

                        _localidad, _especialidad, false, _statusUsuario)

                        .then((userCreds) {

                          // Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Registro realizado'),
                              content: Text('Pendiente de aprobacion del administrador'),

                              actions: [
                                TextButton(
                                  child: Text('Ok',
                                      style: TextStyle(
                                          color: Colores().colorAzul,
                                          fontFamily: 'Trueno',
                                          fontSize: 11.0,
                                          decoration: TextDecoration.underline
                                      )),
                                  onPressed: Navegacion(context).navegarALogin,



                                ),


                              ],

                            );

                          }

                      );


                        }).catchError((e) {

                          ErrorHandler().errorDialog(context, e);

                        });

                  }
                },

              ),

              SizedBox(height: 20.0),

            ]),

          ),
    );
  }
}
