// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:imagine_apps/providers/db_provider.dart';
import 'package:imagine_apps/screens/add_work.dart';
import 'package:imagine_apps/screens/edit_work.dart';
import 'package:imagine_apps/screens/login.dart';
import 'package:provider/provider.dart';

class Item {
  final String titulo;
  final String descripcion;
  final String fechaVencimiento;
  final String estado;

  Item(this.titulo, this.descripcion, this.estado, this.fechaVencimiento);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Item> empleos = [
    Item("Ejemplo 1", "adkjaskdjsakdjsa", "Pendiente", "19/04/32"),
    Item("Ejemplo 2", "adkjaskdjsakdjsa", "Pendiente", "19/04/32"),
    Item("Ejemplo 3", "adkjaskdjsakdjsa", "En progreso", "19/04/32"),
    Item("Ejemplo 4", "adkjaskdjsakdjsa", "En progreso", "19/04/32"),
    Item("Ejemplo 5", "adkjaskdjsakdjsa", "Completado", "19/04/32"),
  ];

  TabController? _tabController;

  final List<Map<String, dynamic>> _tareas = [];

  @override
  void initState() {
    super.initState();
    _Inicializardatos();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _Inicializardatos() async {
    final dbProvider db = Provider.of<dbProvider>(context, listen: false);
    await db.getTareas();
    _tareas.addAll(db.tareas);
    setState(() {});
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  List getEmpleosPorEstado(String estado) {
    return _tareas.where((empleo) => empleo['estado'] == estado).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddWorkForm()));
              },
              icon: const Icon(Icons.add_circle_rounded, size: 35)),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginForm(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.logout, size: 35))
        ],
        backgroundColor: Colors.orange,
        title: const Text('Empleos por Estado'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: 'Pendiente'),
            const Tab(text: 'En Progreso'),
            const Tab(text: 'Completado'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEmpleosList(getEmpleosPorEstado('Pendiente')),
          _buildEmpleosList(getEmpleosPorEstado('En Progreso')),
          _buildEmpleosList(getEmpleosPorEstado('Completado')),
        ],
      ),
    );
  }

  Widget _buildEmpleosList(List<dynamic> empleosList) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: empleosList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.only(right: 30, left: 30, top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.work,
                size: 100,
                color: Colors.orange,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Titulo:',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(empleosList[index]['titulo']),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Descripción:',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(empleosList[index]['descripcion']),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Fecha Vencimiento:',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(empleosList[index]['fecha_vencimiento']),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Estado:',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(empleosList[index]['estado']),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditWorkForm(
                              id: empleosList[index]['id'],
                            ),
                          ));
                    },
                    child: const Text('Editar',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                    ),
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content: const Text(
                                '¿Seguro que quieres eliminar este elemento?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final dbProvider db = Provider.of<dbProvider>(
                                      context,
                                      listen: false);
                                  db.deleteWork(empleosList[index]['id']);

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm == true) {
                        setState(() {});
                      }
                    },
                    child: const Text('Eliminar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
