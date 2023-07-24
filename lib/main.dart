import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:universal_platform/universal_platform.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/util/utils.dart';

Future<void> main() async {
  AppSplash.preserve(
    WidgetsFlutterBinding.ensureInitialized(),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterError.onError = (details) => log(
        details.exceptionAsString(),
        stackTrace: details.stack,
      );
  // Bloc.observer = AppBlocObserver();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(
    SettingsService(),
  );

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runZonedGuarded(
    () => runApp(
      DevicePreview(
        enabled: !kReleaseMode && UniversalPlatform.isDesktop,
        storage: DevicePreviewStorage.none(),
        tools: [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(
            onScreenshot: (context, screenshot) => screenshotAsFiles(
              Directory(
                path.join(
                  Directory.current.path,
                  'screenshots',
                  '${settingsController.themeMode.name} theme',
                ),
              ),
            ).call(context, screenshot),
          ),
        ],
        builder: (context) => MyApp(settingsController: settingsController),
      ),
    ),
    (error, stack) => log(
      '$error',
      stackTrace: stack,
    ),
  );
}
