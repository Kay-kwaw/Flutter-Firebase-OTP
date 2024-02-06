import 'package:firebase_auth/firebase_auth.dart';


//Fucntion to initialize the phone verification process

Future<void> verifyPhoneNumber(String number) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: number,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    },
    codeSent: (String verificationId, int? resendToken) async {
      // Update the UI - wait for the user to enter the SMS code
      String smsCode = 'xxxx';

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
    },
    timeout: const Duration(seconds: 60),
    codeAutoRetrievalTimeout: (String verificationId) {},
  );

}