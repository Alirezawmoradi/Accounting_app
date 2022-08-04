import 'package:accounting/const.dart';
import 'package:flutter/material.dart';
class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String Hint;
  bool isNumber;
   MyTextField({Key? key, required this.Hint,required this.isNumber, required this.controller}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState(Hint,isNumber,controller);
}

class _MyTextFieldState extends State<MyTextField> {
  final String Hint;
  final TextEditingController controller;
  bool isNumber;
  _MyTextFieldState(this.Hint,this.isNumber, this.controller);
  @override
  Widget build(BuildContext context) {
    return   TextField(
      controller: controller,
      cursorColor: Colors.black26,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kPurpleColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:const BorderSide(
            color: Color(0xfff5f5f5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:const BorderSide(
            color: kPurpleColor,
          ),
        ),
        hintText: Hint,
        filled: true,
        hintTextDirection: TextDirection.rtl,
      ),
      keyboardType: isNumber?TextInputType.number:TextInputType.text,
    );

  }
}
