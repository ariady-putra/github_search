import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class AppPlatform {
  static bool isPhone(BuildContext context) {
    if (!DevicePreview.isEnabled(context)) {
      return !UniversalPlatform.isDesktopOrWeb;
    }

    switch (DevicePreview.platform(context)) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      default:
        return false;
    }
  }

  static bool isDesktop(BuildContext context) {
    if (!DevicePreview.isEnabled(context)) {
      return UniversalPlatform.isDesktop;
    }

    switch (DevicePreview.platform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return true;
      default:
        return false;
    }
  }

  static bool isWeb(BuildContext context) {
    if (!DevicePreview.isEnabled(context)) {
      return UniversalPlatform.isWeb;
    }

    return true;
  }
}
