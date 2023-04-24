import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({Key? key}) : super(key: key);

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  String password = '';

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
      width: 330,
      child: TextFormField(
        key: const ValueKey('password'),
        obscureText: _obscured,
        focusNode: textFieldFocusNode,
        validator: (value) {
          if (value!.length < 6) {
            return 'Please Enter Password of min length 6';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            password = value!;
          });
        },
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              )),
          label: const Text("Password", style: TextStyle(color: Colors.black)),
          hintText: "Password",
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 94, 92, 88),
          ),
          prefixIcon: const SizedBox(
            width: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                IconlyLight.lock,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
          suffixIcon: SizedBox(
            width: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _toggleObscured,
                child: Icon(
                  _obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
