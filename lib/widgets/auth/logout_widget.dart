import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2_213094/services/auth_service.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signout(context: context);
      },
      child: const Text("Sign Out", style: TextStyle(fontSize: 20)),
    );
  }
}