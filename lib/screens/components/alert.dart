import 'package:flutter/material.dart';

showAlert(
    {BuildContext bContext,
    String title,
    String content,
    VoidCallback callback}) {
  return showDialog(
      context: bContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title ?? ""
          ),
          content: Text(content ?? ""),
          actions: [
            TextButton(
                onPressed: () => {Navigator.pop(context), callback()},
                child: Text("Ok"))
          ],
        );
      });
}
