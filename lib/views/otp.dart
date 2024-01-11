import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Otp_Screen extends StatefulWidget {
  const Otp_Screen({super.key});

  @override
  State<Otp_Screen> createState() => _Otp_ScreenState();
}

class _Otp_ScreenState extends State<Otp_Screen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F4F8),
        title: const Text("OTP Verification", style: TextStyle(fontSize: 17)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Enter the OTP sent to your mobile number", style: TextStyle(fontSize: 17)),
              OTPTextField(
                width: 400,
                style: const TextStyle(fontSize: 18),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  if (kDebugMode) {
                    print("Completed: $pin");
                    // Verify the OTP using Firebase
                    verifyOTP(pin);
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text("Didn't receive the OTP? Resend"),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 12, 16, 19),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyOTP(String otp) async {
    try {
      // Get the verification ID from where you stored it during phone authentication
      String verificationId = "YOUR_VERIFICATION_ID"; // Replace with your actual verification ID

      // Create PhoneAuthCredential using the verification ID and OTP entered by the user
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in with the PhoneAuthCredential
      await _auth.signInWithCredential(credential);

      // You can navigate to the next screen or perform any actions here
    } catch (e) {
      print("Error verifying OTP: $e");
      // Handle OTP verification failure
    }
  }
}
