import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../widgets/drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SettingsList(
          key: GlobalKey(debugLabel: 'Settings'),
          sections: [
            SettingsSection(
              title: const Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  leading: const Icon(Icons.notifications_active),
                  title: const Text('Notifications'),
                  initialValue: true,
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  leading: const Icon(Icons.speaker_notes),
                  title: const Text('Sound'),
                  initialValue: true,
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  leading: const Icon(Icons.vibration),
                  title: const Text('Vibration'),
                  initialValue: true,
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  leading: const Icon(Icons.airplanemode_active),
                  title: const Text('Airplane Mode'),
                  initialValue: true,
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Account'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  value: const Text('English'),
                ),
                SettingsTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Theme'),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Enable custom theme'),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Security'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  value: const Text('English'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Enable custom theme'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
