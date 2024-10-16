import 'package:flutter/material.dart';
import '../../../models/User.dart';
import '../Implementations/studentNavbar.dart';
import '../Implementations/guestNavbar.dart';
import '../Interface/CustomNavigationDrawer.dart';

class NavigationDrawerFactory {
  static Future<CustomNavigationDrawer> createNavigationDrawer(User user) {
    switch (user.role.toLowerCase()) {
      case 'student':
        return Future.value(StudentNavbar(
          userRole: user.role,
          institution: user.institution,
          initialReadyForHire: user.readyForHire,
          profilePicture: user.profilePictureUrl,
        ));
      default:
        return Future.value(GuestNavbar());
    }
  }
}
