import 'package:flutter/material.dart';
import 'package:imagine_apps/screens/register.dart';
import 'package:imagine_apps/widgets/card_form.dart';

class FormScreen extends StatelessWidget {
  final Widget form;
  final String nameForm;
  final double height;
  const FormScreen({super.key, required this.form, required this.nameForm, required this.height});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            color: Colors.orange,
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 100),
            child: Image.network('https://uploads-ssl.webflow.com/5ef9e7820240534a394d4b30/5efa4343b71a8f16eb9790e4_logo-negro-negativo.png', width: 400,),
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: height),
              CardForm(name: nameForm,
              child: form),
              const SizedBox(
                height: 30,
              ),
              if (nameForm != "Registro" && nameForm != "Crear" && nameForm != "Agregar Empleo" && nameForm != "Editar Empleo") ...[
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterForm()));
                }, child: const Text("Crea una cuenta", style: TextStyle(color: Colors.black, fontSize: 20)))
              ],
              const SizedBox(
                height: 30,
              )
            ],
          )),
        ],
      ),
    );
  }
}
