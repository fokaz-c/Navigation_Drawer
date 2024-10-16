import 'package:flutter/material.dart';
import '../Interface/navigationdrawer_constants.dart';
import '../Interface/CustomNavigationDrawer.dart';

class GuestNavbar implements CustomNavigationDrawer {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildDrawerHeader(),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.login, color: kIconColor, size: kListTileIconSize),
            title: const Text('Login'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.app_registration, color: kIconColor, size: kListTileIconSize),
            title: const Text('Register'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.info, color: kIconColor, size: kListTileIconSize),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.contact_support, color: kIconColor, size: kListTileIconSize),
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: kHeaderBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_circle,
            size: 64,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome, Guest!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
