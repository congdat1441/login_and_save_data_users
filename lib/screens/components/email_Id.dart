import 'package:flutter/material.dart';

class EmailId extends StatefulWidget {
  const EmailId({Key? key}) : super(key: key);

  @override
  State<EmailId> createState() => _EmailIdState();
}

class _EmailIdState extends State<EmailId> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
      width: 330,
      child: TextFormField(
          key: const ValueKey('email'),
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (value!.isEmpty || !value.contains('@')) {
              return 'Please Enter valid Email';
            } else if (value.length <= 5) {
              return "Not enough required characters";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              email = value!;
            });
          },
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(0),
            )),
            label: Text("Email", style: TextStyle(color: Colors.black)),
            hintText: "Please text your email",
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
