import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_app/main.dart';
import 'package:games_app/providers/auth_provider.dart';
import 'package:games_app/screens/loginscreen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Provider.of<Auth_Provider>(context, listen: false)
                          .login(emailController.text, passwordController.text)
                          .then((loggedIn) {
                        if (loggedIn) {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ScreenRouter(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login failed'),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have an account? ",
                    ),
                    TextButton(
                        child: Text(
                          "Log in",
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Loginscreen()));
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
