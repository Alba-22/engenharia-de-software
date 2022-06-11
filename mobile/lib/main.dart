import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/environment.dart';

import 'app/app_widget.dart';

void main() {
  setupLocator();
  runApp(DevicePreview(
    enabled: Environment.previewEnabled,
    builder: (BuildContext context) {
      return const AppWidget();
    },
  ));
}
