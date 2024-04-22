import 'package:flutter/material.dart';
import 'package:todo_list/util/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  const DialogBox({super.key, required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "save", onPressed: onSave),
                const SizedBox(
                  width: 4,
                ),
                MyButton(
                    text: "cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
