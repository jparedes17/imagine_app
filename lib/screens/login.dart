// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagine_apps/providers/db_provider.dart';
import 'package:imagine_apps/screens/home.dart';
import 'package:imagine_apps/widgets/dialog.dart';
import 'package:imagine_apps/widgets/form_screen.dart';
import 'package:imagine_apps/widgets/input_decorations.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: FormScreen(
      form: _LoginForm(),
      nameForm: 'Login', height: 300,
    ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final dbProvider db = Provider.of<dbProvider>(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailControler = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: emailControler,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es valido';
              },
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.formInputDecoration(
                  hintText: 'jorgeparedesg10@gmail.com',
                  labelText: 'Correo',
                  prefixIcon: const Icon(Icons.email)),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe ser mayor a 5 caracteres';
              },
              autocorrect: false,
              obscureText: true,
              decoration: InputDecorations.formInputDecoration(
                  hintText: 'Contraseña',
                  labelText: '********',
                  prefixIcon: const Icon(Icons.password)),
            ),
            const SizedBox(height: 40),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                ),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  } else {
                    final String? errorMessage = await db.signIn(
                        emailControler.text, passwordController.text);
                    if (errorMessage == null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    } else {
                      Platform.isIOS
                          ? DisplayDialog().displayDialogIOS(
                              context, () {}, errorMessage, 'Aviso')
                          : DisplayDialog().displayDialogAndroid(
                              context, () {}, errorMessage, 'Aviso');
                    }
                  }
                },
                child: const Text(
                  "Ingresar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ));
  }
}
