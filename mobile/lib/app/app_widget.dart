import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:turistando/app/core/router/go_router.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Turistando",
      theme: ThemeData(
        primarySwatch: CColors.primarySwatch,
        fontFamily: Fonts.inter,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
