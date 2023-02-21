import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/view/home_screen/home_screen.dart';
import 'package:quicha/view/login_or_sign_up_screen/login_or_sign_up_screen.dart';
import 'package:quicha/viewModel/check_init_viewmodel/check_init_notifier.dart';

import '../../ui/custom_style.dart';

class CheckInitScreen extends StatelessWidget {
  const CheckInitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundYellow,
      body: _Body(),
    );
  }
}

class _Body extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.read(checkInitProvider);
    final state = ref.watch(checkInitProvider);

    useValueChanged<int, void>(state.routeNumber, (_, __) {
      switch (state.routeNumber) {
        case 200:
          //よくわかんねーから握りつぶした
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    // （2） 実際に表示するページ(ウィジェット)を指定する
                    builder: (context) => LoginOrSignUpScreen()));
          });
          break;
        default:
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    // （2） 実際に表示するページ(ウィジェット)を指定する
                    builder: (context) => HomeScreen()));
          });
          break;
      }
    });

    return Container();
  }
}
