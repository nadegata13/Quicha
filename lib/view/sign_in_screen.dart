import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // 入力内容のvalidationのため
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // 入力内容取得のため
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _onSignIn() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      final user = FirebaseAuth.instance.currentUser!;
      await Future.wait([
        user.updateEmail(email),
        user.updatePassword(password),
      ]);

      await Future.delayed(const Duration(milliseconds: 500));
      // contextを渡す前に、contextが現在のWidgetツリー内に存在しているかどうかチェック
      // 存在しなければ、画面遷移済を意味するので、以降の画面遷移処理は行わない
      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('エラー'),
              content: Text(error.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey, //validation用
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'メールアドレスと紐づける',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 16),
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'メースアドレスを入力してください';
                      }
                      return null;
                    }),
                SizedBox(height: 8),
                TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'パスワード'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (String? value) {
                      if (value?.isEmpty == true) {
                        return 'パスワードを入力してください';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _onSignIn(),
                    child: Text('紐付け'),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
