import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/providers/firebaseProvider.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:provider/provider.dart';

import '../customWidgets/navbar/Factory/navbar_factory.dart';
import '../customWidgets/navbar/Interface/CustomNavigationDrawer.dart';
import '../services/UserDataService.dart';
import '../services/change_profile_picture_service.dart';

class MyHomePage extends StatefulWidget {
  final String userId;

  MyHomePage({required this.userId});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserData();
  }

  Future<User> _fetchUserData() {
    final firebaseProvider = Provider.of<FirebaseProvider>(context, listen: false);
    return UserDataService.fetchUserData(widget.userId, firebaseProvider);
  }

  Future<void> _changeProfilePicture(User user, FirebaseProvider firebaseProvider) async {
    if (!firebaseProvider.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Firebase not initialized')),
      );
      return;
    }

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);

        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        final String? newImageUrl = await ProfilePictureService.uploadProfilePicture(
          userId: user.id,
          imageFile: imageFile,
          firebaseProvider: firebaseProvider,
        );

        if (context.mounted) Navigator.of(context).pop();

        if (newImageUrl != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated successfully'),
              backgroundColor: Colors.green,
            ),
          );

          setState(() {
            _userFuture = _fetchUserData();
          });
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update profile picture'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteProfilePicture(User user, FirebaseProvider firebaseProvider) async {
    if (!firebaseProvider.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Firebase not initialized')),
      );
      return;
    }

    try {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Profile Picture'),
          content: const Text('Are you sure you want to delete your profile picture?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        ),
      );

      if (confirm == true && context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        final bool success = await ProfilePictureService.deleteProfilePicture(
          user.id,
          firebaseProvider,
        );

        if (context.mounted) Navigator.of(context).pop();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(success ? 'Profile picture deleted successfully' : 'Failed to delete profile picture'),
              backgroundColor: success ? Colors.green : Colors.red,
            ),
          );

          if (success) {
            setState(() {
              _userFuture = _fetchUserData();
            });
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context, listen: false);

    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: Text('User data not found')));
        } else {
          final user = snapshot.data!;
          return FutureBuilder<CustomNavigationDrawer>(
            future: NavigationDrawerFactory.createNavigationDrawer(user),
            builder: (context, drawerSnapshot) {
              if (drawerSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              } else if (drawerSnapshot.hasError) {
                return Scaffold(body: Center(child: Text('Error: ${drawerSnapshot.error}')));
              } else {
                final drawer = drawerSnapshot.data;

                return Scaffold(
                  appBar: AppBar(
                    title: const Text('My App'),
                  ),
                  drawer: drawer?.build(context),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: user.profilePictureUrl != null
                              ? NetworkImage(user.profilePictureUrl!)
                              : null,
                          child: user.profilePictureUrl == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Text('Welcome, ${user.role}!'),
                        if (user.institution.isNotEmpty)
                          Text(user.institution),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () => _changeProfilePicture(user, firebaseProvider),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Change Profile Picture'),
                        ),
                        const SizedBox(height: 10),
                        if (user.profilePictureUrl != null)
                          TextButton.icon(
                            onPressed: () => _deleteProfilePicture(user, firebaseProvider),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text('Delete Profile Picture',
                                style: TextStyle(color: Colors.red)
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
