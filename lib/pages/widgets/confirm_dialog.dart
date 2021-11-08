import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context, String title, String content) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red,
            ),
          ),
          child: Text(
            "YES",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            "No",
          ),
        ),
      ],
    ),
  );
}
