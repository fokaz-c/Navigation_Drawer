import 'package:flutter/material.dart';
import '../Interface/customNavigationDrawer.dart';
import '../Interface/navigationDrawer.dart';

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
              // Navigate to login page
              Navigator.pop(context);
              // Add navigation to login page here
            },
          ),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.app_registration, color: kIconColor, size: kListTileIconSize),
            title: const Text('Register'),
            onTap: () {
              // Navigate to registration page
              Navigator.pop(context);
              // Add navigation to registration page here
            },
          ),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.info, color: kIconColor, size: kListTileIconSize),
            title: const Text('About Us'),
            onTap: () {
              // Navigate to about page
              Navigator.pop(context);
              // Add navigation to about page here
            },
          ),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.contact_support, color: kIconColor, size: kListTileIconSize),
            title: const Text('Contact'),
            onTap: () {
              // Navigate to contact page
              Navigator.pop(context);
              // Add navigation to contact page here
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
