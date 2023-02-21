import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/view/create_new_account_screen/new_account_screen.dart';

final loginProvider =
    StateNotifierProvider.autoDispose(((ref) => LoginNotifier()));

class LoginNotifier extends StateNotifier {
  LoginNotifier() : super(null);

  void aiueo() {}

  Future<void> onSignInWithAnonymousUser(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.signInAnonymously();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewAccountScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> anonymousEmailLink({
    required String email,
    required String password,
  }) async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser!;

    try {
      await Future.wait([
        user.updateEmail(email),
        user.updatePassword(password),
      ]);
    } catch (error) {
      print(error);
    }
  }

  Future<void> verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+81$phone',
      verificationCompleted: (credential) {
        print("success");
      },
      verificationFailed: (e) {
        print("failed");
        print(e.message);
      },
      codeSent: (verificationId, int? resendToken) async {
        print("smscode");
        String smsCode = '1234';

        print("電話番号" + phone);

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        try {
          await FirebaseAuth.instance.signInWithCredential(credential);
        } catch (e) {
          print("Login not successful");
        }

// ダイアログでユーザーの認証コード入力を待つ
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }
}
