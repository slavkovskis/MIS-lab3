import 'package:flutter/material.dart';
import 'package:lab2_213094/provider/auth_provider.dart';
import 'package:lab2_213094/services/auth_service.dart';
import 'package:lab2_213094/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisibility = Provider.of<FirebaseAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Register", textAlign: TextAlign.center),
        ],
      )),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //EMAIL
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.green,
                      labelText: "Email",
                      hintText: "Enter Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isValidEmail(value)) {
                      return 'Email not valid!';
                    }
                    return null;
                  },
                ),
              ),

              //PASSWORD
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: passwordVisibility.isObscure,
                  decoration: InputDecoration(
                    focusColor: Colors.green,
                    border: const OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter password",
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisibility.isObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        passwordVisibility.toggleVisibility();
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password should not have less than 6 characters.';
                    }
                    return null;
                  },
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Already have an account? Sing In!")),
              ]),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline_sharp),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthService().signup(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')),
                        );
                      }
                    },
                    label: const Text('Register'),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
