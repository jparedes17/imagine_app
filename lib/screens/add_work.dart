import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagine_apps/main.dart';
import 'package:imagine_apps/providers/db_provider.dart';
import 'package:imagine_apps/screens/home.dart';
import 'package:imagine_apps/widgets/dialog.dart';
import 'package:imagine_apps/widgets/form_screen.dart';
import 'package:imagine_apps/widgets/input_decorations.dart';
import 'package:provider/provider.dart';

class AddWorkForm extends StatelessWidget {
  const AddWorkForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Agregar Empleo'),
      ),
      body: FormScreen(form: _AddWorkForm(), nameForm: 'Agregar Empleo', height: 200,),
    );
  }
}

class _AddWorkForm extends StatelessWidget {
  _AddWorkForm({
    super.key,
  });

  String? selectedEstado = "";

  @override
  Widget build(BuildContext context) {
    final dbProvider db = Provider.of<dbProvider>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController descripcionControler = TextEditingController();
    final TextEditingController fechaController = TextEditingController();

    return Container(
      child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
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
                      final String? errorMessage = await db.addWork(
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
                              content: Text('Empleo agregado exitosamente'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    // Use Navigator to navigate to the HomeScreen
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
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
                    "Agregar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ],
          )),
    );
  }
}
