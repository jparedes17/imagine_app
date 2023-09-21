import 'package:flutter/material.dart';
import 'package:imagine_apps/screens/login.dart';
import 'package:imagine_apps/screens/register.dart';
import 'package:imagine_apps/widgets/card_form.dart';
import 'package:imagine_apps/widgets/input_decorations.dart';

class FormScreen extends StatelessWidget {
  final Widget form;
  final String nameForm;
  final double height;
  const FormScreen({super.key, required this.form, required this.nameForm, required this.height});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //authbackground
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            // orangebox
            width: double.infinity,
            height: size.height * 0.4,
            color: Colors.orange,
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: height),
              CardForm(name: nameForm,
              child: form),
              SizedBox(
                height: 30,
              ),
              if (nameForm != "Register" && nameForm != "Crear" && nameForm != "Agregar Empleo" && nameForm != "Editar Empleo") ...[
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterForm()));
                }, child: Text("Crea una cuenta"))
              ],
              SizedBox(
                height: 30,
              )
            ],
          )),
        ],
      ),
    );
  }
}
