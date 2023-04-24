import 'package:flutter/material.dart';

class NameAccount extends StatefulWidget {
  const NameAccount({Key? key}) : super(key: key);

  @override
  State<NameAccount> createState() => _NameAccountState();
}

class _NameAccountState extends State<NameAccount> {
  String fullname = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
      // color: Colors.orange,
      width: 330,
      child: TextFormField(
          key: const ValueKey('fullness'),
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              fullname = value!;
            });
          },
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                )),
            label: Text("Enter Full Name", style: TextStyle(color: Colors.black)),
            hintText: "Please text your name",
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 94, 92, 88),
            ),
            prefixIcon: SizedBox(
              width: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.email_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          )),
    );
  }
}
