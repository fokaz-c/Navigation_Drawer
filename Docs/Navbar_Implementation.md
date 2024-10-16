# NavigationDrawerFactory

## Purpose

`NavigationDrawerFactory` is a factory class that generates instances of custom navigation drawers based on the user's role. This factory uses the `User` model to determine the appropriate drawer.

## Class Definition

```dart
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
```

## Dependencies

- **Imports**:
    - `flutter/material.dart`
    - `User` model (`../../../models/User.dart`)
    - `StudentNavbar` (`../Implementations/studentNavbar.dart`)
    - `GuestNavbar` (`../Implementations/guestNavbar.dart`)
    - `CustomNavigationDrawer` interface (`../Interface/CustomNavigationDrawer.dart`)

## Parameters

- **User user**: An instance of the `User` model class. Properties used include:
    - `role`: Defines the role (e.g., `'student'` or other roles) for determining the drawer.
    - `institution`: Represents the institution to which the user belongs.
    - `readyForHire`: Boolean value indicating if the user is ready for hire.
    - `profilePictureUrl`: URL for the user's profile picture.

## Returns

- Returns a `Future<CustomNavigationDrawer>` object:
    - **StudentNavbar**: Returned if `user.role` is `'student'`.
    - **GuestNavbar**: Returned by default for other roles.