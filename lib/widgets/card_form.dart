import 'package:flutter/material.dart';

class CardForm extends StatelessWidget {
  final Widget child;
  final String name;
  const CardForm({super.key, required this.child, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
            ]),
        child: Column(children: [
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 30),
          child
        ]),
      ),
    );
  }
}
