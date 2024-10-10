import 'package:flutter/material.dart';
import '../../../models/User.dart';
import '../Implementations/studentNavbar.dart';
import '../Implementations/guestNavbar.dart';
import '../Interface/navigationDrawer.dart';

class NavigationDrawerFactory {
  static Future<CustomNavigationDrawer> createNavigationDrawer(User user) {
    switch (user.role.toLowerCase()) {
      case 'student':
        return Future.value(StudentNavbar(
          userRole: user.role,
          institution: user.institution,
          initialReadyForHire: user.readyForHire,
          profilePicture: user.profilePictureUrl, // Pass the profile picture URL here
        ));
      default:
        return Future.value(GuestNavbar());
    }
  }
}
