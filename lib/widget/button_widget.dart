
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final VoidCallback onClicked;

   const ButtonWidget({Key? key,
    required this.text,
    required this.onClicked,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        primary: Colors.white ,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        )
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: onClicked,
    );
  }


}