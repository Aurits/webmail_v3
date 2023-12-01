import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../widgets/drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
      body: Container(
        height: MediaQuery.of(context).size.height, // Set a fixed height
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SettingsList(
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
                        SettingsTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile'),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          leading: const Icon(Icons.phone),
                          title: const Text('Phone'),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          leading: const Icon(Icons.language),
                          title: const Text('Language'),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          leading: const Icon(Icons.help),
                          title: const Text('Help'),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: const Text('Security'),
                      tiles: <SettingsTile>[
                        SettingsTile(
                          leading: const Icon(Icons.lock),
                          title: const Text('Change Password'),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile.switchTile(
                          onToggle: (value) {},
                          leading: const Icon(Icons.fingerprint),
                          title: const Text('Enable fingerprint'),
                          initialValue: false,
                        ),
                        SettingsTile.switchTile(
                          onToggle: (value) {},
                          leading: const Icon(Icons.lock),
                          title: const Text('Lock app in background'),
                          initialValue: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
