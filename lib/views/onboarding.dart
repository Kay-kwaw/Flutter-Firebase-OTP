import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to HealthHub", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/Doctor.png',
                height: 150,
                width: 150,
                alignment: Alignment.center,)
              ),
          ],
        )
          )
    );
  }
}