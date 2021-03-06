import 'package:flutter/material.dart';
import 'package:vitality/components/fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final String? text;
  final String? hint;
  final Icon? prefixIcon;
  final IconButton? suffixIconButton;
  final String? type;
  final TextEditingController? controller;
  final bool ob;
  final TextInputType? inputType;
  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.prefixIcon,
    required this.controller,
    required this.suffixIconButton,
    required this.ob,
    required this.type,
    required this.inputType,
    required this.hint,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 20,
                offset: Offset(1, 2))
          ]),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          keyboardType: widget.inputType,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: widget.hint,
              labelText: widget.text,
              labelStyle: AppFonts.tajawal14BlackW400,
              fillColor: Colors.white,
              focusColor: Colors.white,
              filled: true,
              suffixIcon: widget.suffixIconButton,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: widget.prefixIcon),
          validator: (value) {
            if (value!.isEmpty) {
              return "required";
            } else if (widget.type == "email") {
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return "enter the currected email";
              }
            } else if (widget.type == "phone") {
              if (value.length != 10) {
                return "Phone number must be 10 numbers";
              }
            } else if (widget.type == "pass") {
              if (!RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,15}$')
                  .hasMatch(value)) {
                return "The password must contain : \n *More than 8 and less than 15 characters \n *Upper case \n *lowercase \n *Numeric Number \n *Symbols (! @ # \$ & * ~)";
              }
            }
            return null;
          },
          obscureText: widget.ob,
          controller: widget.controller,
        ),
      ),
    );
  }
}
