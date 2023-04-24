import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:login_and_save/firebase/auth_services.dart';
import 'package:login_and_save/screens/login.dart';

import '../firebase/authFunctions.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page screen"),
        leading: IconButton(
          icon: const Icon(
            IconlyBroken.arrowLeft,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () async {
            await AuthServices.logoutUser(context);

            //ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginForm()));
          },
        ),
      ),
      body: const Center(
        child: Text("THIS IS HOMEPAGE"),
      ),
    );
  }
}
