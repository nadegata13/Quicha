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
      verificationCompleted: ( credential) {
        print("success");
      },
      verificationFailed: (e) {
        print("failed");
        print(e.message);
      },
      codeSent:  (verificationId,int? resendToken)async{
        print("smscode");
        String smsCode = '1234';

        print("電話番号" + phone);

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        try{
          await FirebaseAuth.instance.signInWithCredential(credential);
        } catch(e){
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
