import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark/config/svgs.dart';

import '../controller/auth_service.dart';
import '../pages/settingsPage/settings_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final auth = AuthService();

  void logout() {
    // get auth service
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                            height: 60,
                            child: SvgPicture.asset(AssetsSvgs.appIcon)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${auth.currentUser()!.email}")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text('H O M E'),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text('S E T T I N G S'),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: const Icon(Icons.logout_outlined),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
