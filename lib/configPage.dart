import 'package:provider/provider.dart';
import 'package:sensor_flutter_app/model_theme.dart';
import 'package:sensor_flutter_app/notificationsPage.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Ajustes'),
          actions: [
           
          ],
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Apariencia'),
              tiles: <SettingsTile>[
             
                SettingsTile.navigation(
                    title: const Text('Dark Mode'),
                    value: Row(children: [Text('Activar/Desactivar'),IconButton(
                        icon: Icon(themeNotifier.isDark
                            ? Icons.nightlight_round
                            : Icons.wb_sunny),
                        onPressed: () {
                          themeNotifier.isDark
                              ? themeNotifier.isDark = false
                              : themeNotifier.isDark = true;
                        })]))
              ],
            ),
          ],
        ),
      );
    });
  }
}
