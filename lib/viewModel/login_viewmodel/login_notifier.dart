import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider.autoDispose(
    ((ref) => LoginNotifier())
);


class LoginNotifier extends StateNotifier{
  LoginNotifier() : super(null);

  void aiueo() {

  }
  Future<void> verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+81$phone',
      timeout: Duration(seconds: 5),
      verificationCompleted: ( credential) {
        print("success");
      },
      verificationFailed: (e) {
        print("failed");
        print(e.message);
      },
      codeSent:  (s,int? a){
        final smsCode = '';
        print("smscode");
        print(s);
        print(a.toString());
// ダイアログでユーザーの認証コード入力を待つ
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }
}
