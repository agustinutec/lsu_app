import 'package:flutter/material.dart';
import 'package:lsu_app/modelo/Usuario.dart';
import 'package:lsu_app/pantallas/Biblioteca/AltaContenido.dart';
import 'package:lsu_app/pantallas/Biblioteca/Biblioteca.dart';
import 'package:lsu_app/pantallas/Categorias/AltaCategoria.dart';
import 'package:lsu_app/pantallas/Categorias/Categorias.dart';
import 'package:lsu_app/pantallas/Gestion%20de%20Usuario/GestionUsuarios.dart';
import 'package:lsu_app/pantallas/Gestion%20de%20Usuario/Perfil.dart';
import 'package:lsu_app/pantallas/Glosario/AltaSenia.dart';
import 'package:lsu_app/pantallas/Glosario/Glosario.dart';
import 'package:lsu_app/pantallas/Login/Login.dart';
import 'package:lsu_app/pantallas/Login/PaginaInicial.dart';
import 'package:lsu_app/pantallas/Login/Principal.dart';
import 'package:lsu_app/pantallas/Login/Registrarse.dart';
import 'package:lsu_app/pantallas/Login/ResetPassword.dart';
import 'package:lsu_app/pantallas/Noticias/Noticias.dart';
import 'package:lsu_app/servicios/AuthService.dart';

/*
Clase que controla la navegacion entre pantallas del sistema
 */
class Navegacion {
  BuildContext context;

  Navegacion(this.context);

  void _cerrarSesion() {
    AuthService().signOut();
  }

  void navegarAGlosario() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Glosario(),
        ));
  }

  void navegarABiblioteca() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Biblioteca(),
        ));
  }

  void navegarANoticias() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Noticias(),
        ));
  }

  void navegarACategorias() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Categorias(),
        ));
  }

  void navegarAPerfil(Usuario usuario) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Perfil(usuario: usuario),
        ));
  }


  void navegarAltaSenia() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AltaSenia(),
        ));
  }

  void navegarALogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  void navegarALoginDest() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  void navegarARegistrarse() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Registrarse(),
        ));
  }

  void navegarAResetPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassword(),
        ));
  }
  void navegarAPaginaInicial() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PaginaInicial()));
  }

  void navegarAPaginaInicialDest() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaInicial(),
        ));
  }

  void navegarAPaginaGestionUsuario() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GestionUsuarios(),
        ));
  }

  void navegarAAltaCategoria() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AltaCategoria(),
        ));
  }

  void navegarAPrincipalDest() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Principal(),
        ));
  }

  void navegarAltaContenido() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AltaContenido(),
        ));
  }





}
