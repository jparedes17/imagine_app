import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imagine_apps/providers/db_provider.dart';
import 'package:imagine_apps/screens/home.dart';
import 'package:imagine_apps/widgets/dialog.dart';
import 'package:imagine_apps/widgets/form_screen.dart';
import 'package:imagine_apps/widgets/input_decorations.dart';
import 'package:provider/provider.dart';

class EditWorkForm extends StatelessWidget {
  final int id;
  const EditWorkForm({Key? key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Editar Estado Empleo'),
      ),
      body: FormScreen(form: _EditWorkForm(id: id,), nameForm: 'Editar Empleo', height: 200,),
    );
  }
}

class _EditWorkForm extends StatefulWidget {
  final int id;
  _EditWorkForm({
    super.key, required this.id,
  });

  @override
  State<_EditWorkForm> createState() => _EditWorkFormState();
}

class _EditWorkFormState extends State<_EditWorkForm> {
  String? selectedEstado = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionControler = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  late int id = 0;

  @override
  void initState() {
    super.initState();
    _Inicializardatos();
  }

  Future<void> _Inicializardatos() async {
    final dbProvider db = Provider.of<dbProvider>(context, listen: false);
  
  // Filtrar la lista de tareas para encontrar la tarea con el ID proporcionado
  final tarea = db.tareas.firstWhere((tarea) => tarea['id'] == widget.id);

  tituloController.text = tarea['titulo'].toString();
  descripcionControler.text = tarea['descripcion'].toString();
  fechaController.text = tarea['fecha_vencimiento'].toString();
  selectedEstado = tarea['estado'];
  id = tarea['id'];
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider db = Provider.of<dbProvider>(context);
    return Container(
      child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                controller: tituloController,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'Debes agregar un titulo al empleo';
                },
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: InputDecorations.formInputDecoration(
                    hintText: '',
                    labelText: 'Titulo Empleo',
                    prefixIcon: Icon(Icons.password)),
              ),
              const SizedBox(height: 40),
              TextFormField(
                enabled: false,
                controller: descripcionControler,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'Debes agregar una descripción';
                },
                keyboardType: TextInputType.multiline,
                autocorrect: false,
                decoration: InputDecorations.formInputDecoration(
                    hintText: '',
                    labelText: 'Descripción',
                    prefixIcon: Icon(Icons.password)),
              ),
              const SizedBox(height: 40),
              TextFormField(
                enabled: false,
                controller: fechaController,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'Debes agregar una fecha de vencimiento';
                },
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: InputDecorations.formInputDecoration(
                    hintText: '',
                    labelText: 'Fecha de vencimiento',
                    prefixIcon: Icon(Icons.password)),
              ),
              SizedBox(height: 40),
              DropdownButtonFormField(
                hint: Text('Estado'),
                icon: Icon(Icons.stacked_bar_chart),
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'Debes poner un estado';
                },
                items: [
                  DropdownMenuItem(
                    child: Text('Pendiente'),
                    value: 'Pendiente',
                  ),
                  DropdownMenuItem(
                    child: Text('En Progreso'),
                    value: 'En Progreso',
                  ),
                  DropdownMenuItem(
                    child: Text('Completado'),
                    value: 'Completado',
                  ),
                ],
                onChanged: (value) {
                  selectedEstado = value!;
                },
              ),
              SizedBox(height: 40),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    } else {
                      final String? errorMessage = await db.EditWork(
                          id,
                          tituloController.text,
                          descripcionControler.text,
                          fechaController.text,
                          selectedEstado!);

                      if (errorMessage == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Aviso'),
                              content: Text('Empleo editado exitosamente'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    // Use Navigator to navigate to the HomeScreen
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                        (route) => false);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Platform.isIOS
                            ? DisplayDialog().displayDialogIOS(
                                context, () {}, errorMessage!, 'Aviso')
                            : DisplayDialog().displayDialogAndroid(
                                context, () {}, errorMessage!, 'Aviso');
                      }
                    }
                  },
                  child: Text(
                    "Editar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ],
          )),
    );
  }
}
