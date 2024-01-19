import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class AppLargeText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
   AppLargeText({super.key, required this.text,required this.size,required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: textColor),);
  }
}

class AppTextField extends StatelessWidget {
  final String hinttextl;
   AppTextField({super.key,required this.hinttextl});

  @override
  Widget build(BuildContext context) {

    return Container(height: 50,
      child: TextField(
        style: TextStyle(),
        decoration: InputDecoration(
          //  labelText: 'enter',
          hintText:hinttextl,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

