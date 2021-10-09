import 'package:flutter/cupertino.dart';

class Validar {

//To check fields during submit
  camposVacios(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

//Valido el correo y su formato
  String validarCorreo(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingresa un correo valido';
    else
      return null;
  }

  // Validar campo celular
  String validarCelular(String value){
    Pattern pattern =  r'(^09+[0-9]{7}$)';
    RegExp regex = new RegExp(pattern);
    if(!regex.hasMatch(value))
      return 'El número de celular debe comenzar con 09 y tener un largo de 9 caracteres';
    else
      return null;
  }

  String validarPassword(String value){
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
    RegExp regex = new RegExp(pattern);

    if(!regex.hasMatch(value))
      return "Formato: 1 Mayúsc., 1 num., 1 carácter especial";
    else
      return null;
  }
}
