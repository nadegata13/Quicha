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
//   Future<void> verifyPhone(String phone) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+81$phone',
//       verificationCompleted: ( credential) {},
//       verificationFailed: (e) {
//         if (e.code == 'invalid-phone-number') {
//           print('電話番号が正しくありません。');
//         } else {
//           print("正しい");
//         }
//       },
//       codeSent:  (s,int? a){
//         final smsCode = '';
// // ダイアログでユーザーの認証コード入力を待つ
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
}
