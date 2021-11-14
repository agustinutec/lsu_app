import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lsu_app/manejadores/Colores.dart';
import 'package:lsu_app/manejadores/Validar.dart';
import 'package:lsu_app/servicios/AuthService.dart';
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
  List departamentos = ['ARTIGAS', 'CANELONES', 'CERRO LARGO', 'COLONIA', 'DURAZNO', 'FLORES', 'FLORIDA',
    'LAVALLEJA', 'MALDONADO', 'MONTEVIDEO', 'PAYSANDU', 'RIO NEGRO', 'RIVERA', 'ROCHA', 'SALTO', 'SORIANO',
    'SAN JOSE', 'TACUAREMBO', 'TREINTA Y TRES'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: formularioRegistro(context))));
  }

  formularioRegistro(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          BarraDeNavegacion(
            titulo: Text("REGISTRARSE",
                style: TextStyle(fontFamily: 'Trueno', fontSize: 14)),
          ),

          SizedBox(height: 30.0),

          //CORREO
          TextFieldTexto(
              nombre: 'CORREO',
              icon: Icon(Icons.alternate_email_rounded),
              valor: (value) {
                this._email = value.toLowerCase();
              },
              validacion: (value) => value.isEmpty
                  ? 'Campo obligatorio'
                  : Validar().validarCorreo(value)),

          // CONTRASEÑA
          TextFieldContrasenia(
              nombre: 'CONTRASEÑA',
              icon: Icon(Icons.lock_outline),
              valor: (value) {
                this._password = value;
              },
              validacion: (value) {
                if (value.isEmpty) {
                  return 'Campo obligatorio';
                } else if (value.length <= 8) {
                  return 'La contraseña debe contener mas de 8 caracteres';
                } else {
                  return Validar().validarPassword(value);
                }
              }),

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
              validacion: (value) => value.isEmpty
                  ? 'Campo obligatorio'
                  : Validar().validarCelular(value)),

          // DEPARTAMENTO
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: DropdownSearch(
              items: departamentos,
              onChanged: (value){
                setState(() {
                  this._localidad = value;
                });
              },
              validator: ((dynamic value) {
                if (value == null) {
                  return "Campo obligatorio";
                } else {
                  return null;
                }
              }
                  ),
              showSearchBox: true,
              clearButton: Icon(Icons.close,
                  color: Colores().colorSombraBotones),
              dropDownButton: Icon(Icons.arrow_drop_down,
                  color: Colores().colorSombraBotones),
              showClearButton: true,
              mode: Mode.DIALOG,
              dropdownSearchDecoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12,
                      color: Colores().colorSombraBotones),
                  hintText: "DEPARTAMENTO",
                  prefixIcon: Icon(Icons.location_city_outlined),
                  focusColor: Colores().colorSombraBotones,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colores().colorSombraBotones),
                  )),

            ) ,
          ),

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
                String _statusUsuario = 'PENDIENTE';

                if (Validar().camposVacios(formKey)) {
                  AuthService()

                      //dejo mi UID vacia ya que la obtengo en mi manejador luego de hacer el create user.

                      .signUp(
                          '',
                          _email,
                          _password,
                          _nombreCompleto,
                          _telefono,
                          _localidad,
                          _especialidad,
                          false,
                          _statusUsuario,
                          context);
                }
              }),

          SizedBox(height: 20.0),
        ]),
      ),
    );
  }
}