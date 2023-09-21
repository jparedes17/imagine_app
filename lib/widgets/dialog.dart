import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayDialog {
  
  void displayDialogIOS(
      BuildContext context, Function action, String msg, String title) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return (CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(msg),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                action();
                Navigator.pop(context);
              },
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ));
      }),
    );
  }

  void displayDialogAndroid(
      BuildContext context, Function action, String msg, String title) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(msg),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(25),
          ),
          actions: [
            TextButton(
              onPressed: () {
                action();
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }}