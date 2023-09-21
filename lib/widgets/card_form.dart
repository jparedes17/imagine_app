import 'package:flutter/material.dart';
import 'package:imagine_apps/widgets/input_decorations.dart';

class CardForm extends StatelessWidget {
  final Widget child;
  final String name;
  CardForm({super.key, required this.child, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
            ]),
        child: Column(children: [
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 30),
          child
        ]),
      ),
    );
  }
}
