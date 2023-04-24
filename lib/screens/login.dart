import 'package:flutter/material.dart';
import 'package:login_and_save/screens/home_screen.dart';
import 'package:login_and_save/screens/sign_up.dart';

import '../firebase/authFunctions.dart';
import 'components/email_Id.dart';
import 'components/password.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  String email = '';
  String password = '';
  String fullname = '';
  bool login = true;

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
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 90,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            customTopCircle(),
            formLoginAndSignup(),
            Container(
              height: 20,
              color: Colors.green,
            )
          ],
        ),
      ),
    ));
  }

  Widget formLoginAndSignup() {
    return Form(
      key: _formKey,
      child: Container(
        //color: Colors.orange,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            login ? addEmail() : nameAccount(),
            login ? addPassword() : addEmail(),
            login ? const SizedBox(height: 100) : addPassword(),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 50, 0),
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      login
                          ? AuthServices.signinUser(email, password, context)
                          : AuthServices.signupUser(
                              email, password, fullname, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    login ? 'LOGIN ' : 'SIGN UP',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    login = !login;
                  });
                },
                child: Text(login
                    ? "Don't have an account? Signup"
                    : "Already have an account? Login"))
          ],
        ),
      ),
    );
  }

  Widget customTopCircle() {
    return Expanded(
      child: Stack(
        children: [
          Positioned(
              top: -240,
              right: 10,
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF0675D6)),
              )),
          Positioned(
              top: -280,
              right: 70,
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF0768D6)),
              )),
          Positioned(
              top: -325,
              right: 135,
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF005DC8)),
              )),
          Positioned(
              top: -310,
              right: 200,
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF0057B9)),
              )),
          Positioned(top: 250, right: 140, child: titleSigninSignupTEST()),
        ],
      ),
    );
  }

  Widget titleSigninSignupTEST() {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                login = !login;
              });
            },
            child: Row(
              children: [login ? titleLogin() : titleSignup()],
            ))
      ],
    );
  }

  Widget titleSignup() {
    return Row(
      children: const [
        Text(
          "Sign up",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 45,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2F3948),
          ),
        ),
        Text(
          "/ ",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2F3948),
          ),
        ),
        Text(
          "Login",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Color(0xFF168AD8),
            decoration: TextDecoration.underline,
          ),
        )
      ],
    );
  }

  Widget titleLogin() {
    return Row(
      children: const [
        Text(
          "Login",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 45,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2F3948),
          ),
        ),
        Text(
          "/ ",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2F3948),
          ),
        ),
        Text(
          "Sign up",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Color(0xFF168AD8),
            decoration: TextDecoration.underline,
          ),
        )
      ],
    );
  }

  Widget nameAccount() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
      width: 330,
      child: TextFormField(
          key: const ValueKey('fullness'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter Full Name';
            } else {
              return null;
            }
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
            label:
                Text("Enter Full Name", style: TextStyle(color: Colors.black)),
            hintText: "Please text your name",
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 94, 92, 88),
            ),
            prefixIcon: SizedBox(
              width: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.abc_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          )),
    );
  }

  Widget addEmail() {
    return Container(
      //color: Colors.pink,
      height: 70,
      padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
      width: 330,
      child: TextFormField(
          key: const ValueKey('email'),
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
                  Icons.email_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          )),
    );
  }

  Widget addPassword() {
    return Container(
      height: 80,
      padding: const EdgeInsets.fromLTRB(0, 20, 30, 10),
      width: 330,
      child: TextFormField(
          key: const ValueKey('password'),
          obscureText: true,
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
            label:
                const Text("Password", style: TextStyle(color: Colors.black)),
            hintText: "Password",
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 94, 92, 88),
            ),
            prefixIcon: const SizedBox(
              width: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.lock_outline,
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
          )),
    );
  }
}
