import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../app.dart';
import '../github_search/github_search_view.dart';
import '../util/utils.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  static const routeName = '/settings';

  final SettingsController controller = MyApp.instance.settingsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.of(context).settings),
        toolbarHeight: UniversalPlatform.isDesktop ? null : toolbarHeight,
      ),
      body: SafeArea(
        child: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              // Glue the SettingsController to the theme selection DropdownButton.
              //
              // When a user selects a theme from the dropdown list, the
              // SettingsController is updated, which rebuilds the MaterialApp.
              child: DropdownButton<ThemeMode>(
                focusColor: Colors.transparent,
                iconEnabledColor: Theme.of(context).secondaryHeaderColor,
                iconDisabledColor: Theme.of(context).disabledColor,
                // Read the selected themeMode from the controller
                value: controller.themeMode,
                // Call the updateThemeMode method any time the user selects a theme.
                onChanged: controller.updateThemeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(AppText.of(context).systemTheme),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(AppText.of(context).lightTheme),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(AppText.of(context).darkTheme),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
