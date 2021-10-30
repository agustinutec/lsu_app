import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:lsu_app/modelo/Senia.dart';

class ControladorSenia {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String nombre;
  String categoria;
  String usuarioAlta;
  String descripcion;
  String urlVideo;
  Senia senia;
  String documentID;

  /*
  Se usa para obtener el objeto Senia
  cuando entro a Visualizarla
   */
  Future<Senia> obtenerSenia(String nombreSenia, String descripcionSenia,
      String categoriaSenia) async {
    await firestore
        .collection('senias')
        .where('nombre', isEqualTo: nombreSenia)
        .where('descripcion', isEqualTo: descripcionSenia)
        .where('categoria', isEqualTo: categoriaSenia)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        nombre = doc['nombre'];
        descripcion = doc['descripcion'];
        usuarioAlta = doc['usuarioAlta'];
        categoria = doc['categoria'];
        urlVideo = doc['videoRef'];
        documentID = doc['documentID'];

        senia = new Senia();
        senia.nombre = nombre;
        senia.descripcion = descripcion;
        senia.usuarioAlta = usuarioAlta;
        senia.categoria = categoria;
        senia.urlVideo = urlVideo;
        senia.documentID = documentID;
      });
    });

    return senia;
  }

  void editarSenia(
      String nombreAnterior,
      String descripcionAnterior,
      String categoriaAnterior,
      String nombreNuevo,
      String descripcionNueva,
      String categoriaNueva) async {
    Senia senia = await obtenerSenia(
        nombreAnterior, descripcionAnterior, categoriaAnterior);
    String docId = senia.documentID;

    firestore.collection("senias").doc(docId).update({
      'nombre': nombreNuevo,
      'descripcion': descripcionNueva,
      'categoria': categoriaNueva,
    }).then((value) => print("Seña Editada correctamente"));
  }

  void eliminarSenia(
    String nombre,
    String descripcion,
    String categoria,
  ) async {
    Senia senia = await obtenerSenia(nombre, descripcion, categoria);
    String docId = senia.documentID;

    // primero elimino la senia
    await firestore
        .collection("senias")
        .doc(docId)
        .delete()
        .then((value) => print("Seña Eliminada correctamente"));

    // luego elimino el video

    await eliminarVideoSenia(senia.urlVideo);
  }

  Future eliminarVideoSenia(String linkVideoRef) async {
    await storage
        .refFromURL(linkVideoRef)
        .delete()
        .then((value) => print("Archivo eliminado correctamente"));
  }

  Future<UploadTask> crearYSubirSenia(
      String nombre,
      String descripcion,
      String categoria,
      String usuarioAlta,
      String destino,
      File archivo) async {
    /*
    Primero subo el archivo
     */
    UploadTask subida;
    String downloadLink;
    String docId = new UniqueKey().toString();
    try {
      final ref = FirebaseStorage.instance.ref(destino);
      subida = ref.putFile(archivo);
      downloadLink = await (await subida).ref.getDownloadURL();

      //TODO chequear que el documentID no se va a repetir en las colecciones
      /*
      Creo la senia luego de obtener el link de la url
       */
      await firestore.collection("senias").doc(docId).set({
        /*
        guardo el docId porque me sirve para luego
        al editar, matchear el documento con el id
        correspondiente a la coleccion para saber identificar
        el doc a editar.
         */
        'documentID': docId,
        'usuarioAlta': usuarioAlta,
        'nombre': nombre,
        'descripcion': descripcion,
        /*
        Con esto me aseguro que no queden espacios y que se guarde en Mayus
         */
        'categoria': categoria,
        'videoRef': downloadLink,
      });
    } on FirebaseException catch (e) {
      print('error al subir archivo ');
      return null;
    }
  }

  /*
  Este metodo se usa para la subida de la seña
  desde la web, ya que el reproductor de video es null en la web
  por lo tanto se pasa como @param un tipo de dato Uint8List
   */
  Future<UploadTask> crearYSubirSeniaBytes(
      String nombre,
      String descripcion,
      String categoria,
      String usuarioAlta,
      String destino,
      Uint8List archivo) async {
    /*
    Primero subo el archivo
     */
    UploadTask subida;
    String downloadLink;
    String docId = new UniqueKey().toString();

    try {
      final ref = FirebaseStorage.instance.ref(destino);
      subida = ref.putData(archivo, SettableMetadata(contentType: "video/mp4"));
      downloadLink = await (await subida).ref.getDownloadURL();

      //TODO chequear que el documentID no se va a repetir en las colecciones
      /*
      Creo la senia luego de obtener el link de la url
       */
      await firestore.collection("senias").doc(docId).set({
        'documentID': docId,
        'usuarioAlta': usuarioAlta,
        'nombre': nombre,
        'descripcion': descripcion,
        'categoria': categoria,
        'videoRef': downloadLink,
      });
    } on FirebaseException catch (e) {
      print('error al subir archivo ');
      return null;
    }
  }

  String obtenerVideoDownloadLink(String url) {
    if (url.isNotEmpty) {
      urlVideo = url;
    }
    return urlVideo;
  }

  Future<List<Senia>> obtenerTodasSenias() async {
    List<Senia> lista = [];

    await firestore
        .collection('senias')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        nombre = doc['nombre'];
        descripcion = doc['descripcion'];
        usuarioAlta = doc['usuarioAlta'];
        categoria = doc['categoria'];
        urlVideo = doc['videoRef'];
        documentID = doc['documentID'];

        senia = new Senia();

        senia.nombre = nombre;
        senia.descripcion = descripcion;
        senia.usuarioAlta = usuarioAlta;
        senia.categoria = categoria;
        senia.urlVideo = urlVideo;
        senia.documentID = documentID;

        lista.add(senia);
      });
    });

    return lista;
  }

  Future<List<Senia>> obtenerSeniasXCategoria(String nombreCategoria) async {
    List<Senia> lista = [];

    await firestore
        .collection('senias')
        .where('categoria', isEqualTo: nombreCategoria.trimLeft().trimRight())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        nombre = doc['nombre'];
        descripcion = doc['descripcion'];
        usuarioAlta = doc['usuarioAlta'];
        categoria = doc['categoria'];
        urlVideo = doc['videoRef'];
        documentID = doc['documentID'];

        senia = new Senia();

        senia.nombre = nombre;
        senia.descripcion = descripcion;
        senia.usuarioAlta = usuarioAlta;
        senia.categoria = categoria;
        senia.urlVideo = urlVideo;
        senia.documentID = documentID;

        lista.add(senia);
      });
    });

    return lista;
  }
}
