import 'package:flutter/material.dart';
import 'package:flutter_application_1/customWidgets/navbar/Interface/navigationDrawer.dart';
import 'Interface/customNavigationDrawer.dart';

class StudentNavbar implements CustomNavigationDrawer {
  final String userRole;
  final String institution;
  final ValueNotifier<bool> readyForHire;

  StudentNavbar({
    required this.userRole,
    required this.institution,
    bool initialReadyForHire = false
  }) : readyForHire = ValueNotifier(initialReadyForHire);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildDrawerHeader(),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.edit, color: kIconColor, size: kListTileIconSize),
            title: Text('Update my profile'),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.inbox, color: kIconColor, size: kListTileIconSize),
            title: Text('My inbox'),
          ),
          Padding(
            padding: kTilePadding.copyWith(top: 16, bottom: 8),
            child: const Text(
              'My Works',
              style: TextStyle(fontWeight: FontWeight.bold, color: kIconColor),
            ),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.work, color: kIconColor, size: kListTileIconSize),
            title: Text('My Projects'),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.school, color: kIconColor, size: kListTileIconSize),
            title: Text('My Training'),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.person, color: kIconColor, size: kListTileIconSize),
            title: Text('My Interview'),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.account_balance_wallet, color: kIconColor, size: kListTileIconSize),
            title: Text('My Wallet'),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.description, color: kIconColor, size: kListTileIconSize),
            title: Text('Generate my CV'),
          ),
          const ListTile(
            contentPadding: kTilePadding,
            leading: Icon(Icons.people, color: kIconColor, size: kListTileIconSize),
            title: Text('Refer a friend & earn'),
          ),
          const Divider(),
          ListTile(
            contentPadding: kTilePadding,
            leading: const Icon(Icons.exit_to_app, color: kIconColor, size: kListTileIconSize),
            title: const Text('Logout'),
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
    return ValueListenableBuilder<bool>(
      valueListenable: readyForHire,
      builder: (context, value, child) {
        return Container(
          padding: kHeaderPadding,
          decoration: const BoxDecoration(
            color: kHeaderBackgroundColor,
          ),
          child: Column(
            children: [
              Container(
                width: kAvatarSize,
                height: kAvatarSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.person, color: kIconColor, size: kAvatarSize * 0.6),
              ),
              const SizedBox(height: 8),
              Text(
                userRole,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                institution,
                style: const TextStyle(color: kSubtitleColor, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ready for Hire', style: TextStyle(color: kTextColor)),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: kCheckboxSize,
                    height: kCheckboxSize,
                    child: Checkbox(
                      value: value,
                      onChanged: (bool? newValue) {
                        readyForHire.value = newValue ?? false;
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}