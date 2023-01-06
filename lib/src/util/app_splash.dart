import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppSplash {
  static void preserve(WidgetsBinding widgetsBinding) =>
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  static void remove() => FlutterNativeSplash.remove();
}
