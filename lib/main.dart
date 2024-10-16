import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/firebaseProvider.dart';
import 'package:flutter_application_1/services/UserDataService.dart';
import 'package:provider/provider.dart';
import 'customWidgets/navbar/Factory/navbar_factory.dart';
import 'customWidgets/navbar/Interface/CustomNavigationDrawer.dart';
import 'models/User.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseProvider = FirebaseProvider();
  await firebaseProvider.initialize();
  runApp(
    ChangeNotifierProvider.value(
      value: firebaseProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(userId: 'abc1'),
    );
  }
}

//TODO:Profile picture stuff

class MyHomePage extends StatelessWidget {
  final String userId;

  MyHomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context, listen: false);

    return FutureBuilder<User>(
      future: UserDataService.fetchUserData(userId, firebaseProvider),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text('User data not found')));
        } else {
          final user = snapshot.data!;
          // Call the createNavigationDrawer method with the User object
          return FutureBuilder<CustomNavigationDrawer>(
            future: NavigationDrawerFactory.createNavigationDrawer(user),
            builder: (context, drawerSnapshot) {
              if (drawerSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(body: Center(child: CircularProgressIndicator()));
              } else if (drawerSnapshot.hasError) {
                return Scaffold(body: Center(child: Text('Error: ${drawerSnapshot.error}')));
              } else {
                final drawer = drawerSnapshot.data;

                return Scaffold(
                  appBar: AppBar(title: Text('My App')),
                  drawer: drawer?.build(context), // Use the drawer.build here
                  body: Center(
                    child: Text('Welcome, ${user.role}!'),
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


