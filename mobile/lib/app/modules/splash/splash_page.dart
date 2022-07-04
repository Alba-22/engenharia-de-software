import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/utils/constants.dart';

import 'splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final store = locator.get<SplashStore>();

  @override
  void initState() {
    super.initState();
    store.manageSplash();
    store.observer(
      onState: (state) {
        if (state is SplashEntryState) {
          context.go("/entry");
        } else if (state is SplashLoginState) {
          context.go("/login");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "${Assets.images}/turistando_logo.png",
        ),
      ),
    );
  }
}
