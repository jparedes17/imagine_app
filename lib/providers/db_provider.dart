import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dbProvider extends ChangeNotifier {
  String _nameResp = "";
  String get name => _nameResp;

  String _emailResp = "";
  String get email => _emailResp;

  List<Map<String, dynamic>> _tareas = [];
  List<Map<String, dynamic>> get tareas => _tareas;

  final String _baseUrl = "192.168.1.12:3000";

  Future<String?> signUp(String nombre, String email, String contrasena) async {
    final authData = <String, dynamic>{
      'nombre': nombre,
      'email': email,
      'contrasena': contrasena
    };

    final url = Uri.http(_baseUrl, '/registro');

    final resp = await http.post(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 500) {
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      return decodedResp['error'];
    } else if (resp.statusCode == 201) {
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      _nameResp = decodedResp['nombre'];
      _emailResp = decodedResp['email'];
      return null;
    }
  }

  Future<String?> signIn(String email, String contrasena) async {
    final authData = <String, dynamic>{
      'email': email,
      'contrasena': contrasena
    };

    final url = Uri.http(_baseUrl, '/inicio-sesion');

    final resp = await http.post(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (resp.statusCode == 500) {
      return decodedResp['error'];
    } else if (resp.statusCode == 401) {
      return decodedResp['error'];
    } else if (resp.statusCode == 404) {
      return decodedResp['error'];
    } else if (resp.statusCode == 200) {
      return null;
    }
  }

   Future<String?> addWork(String titulo, String descripcion, String fecha, String estado) async {
    final authData = <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_vencimiento': fecha,
      'estado': estado
    };

    final url = Uri.http(_baseUrl, '/tareas');

    final resp = await http.post(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (resp.statusCode == 500) {
      return decodedResp['error'];
    } else if (resp.statusCode == 201) {
      return null;
    }
  }

   Future<String?> EditWork(int id,String titulo, String descripcion, String fecha, String estado) async {
    final authData = <String, dynamic>{
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_vencimiento': fecha,
      'estado': estado
    };

    final url = Uri.http(_baseUrl, '/tareas/$id');

    final resp = await http.put(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (resp.statusCode == 500) {
      return decodedResp['error'];
    } else if (resp.statusCode == 201) {
      return null;
    }
  }

  Future<int?> deleteWork(int id) async{
    final authData = <String, dynamic>{
      'id': id,
    };

    final url = Uri.http(_baseUrl, '/tareas/${id}');

    final resp = await http.delete(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (resp.statusCode == 500) {
      return decodedResp['error'];
    } else if (resp.statusCode == 201) {
      return null;
    }
  } 

  getTareas() async {
    final url = Uri.http(_baseUrl, '/tareas');

    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 500) {
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      return decodedResp['error'];
    } else {
      final List<Map<String, dynamic>> decodedResp =
          List<Map<String, dynamic>>.from(json.decode(resp.body));
      _tareas = decodedResp;
    }
  }
}

