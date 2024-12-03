import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/providers/firebaseProvider.dart';
import 'package:flutter_application_1/services/UserDataService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'customWidgets/navbar/Factory/navbar_factory.dart';
import 'customWidgets/navbar/Interface/CustomNavigationDrawer.dart';
import 'models/User.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Create and initialize FirebaseProvider
  final firebaseProvider = FirebaseProvider();
  await firebaseProvider.initialize();

  runApp(
    // Provide FirebaseProvider to the widget tree
    ChangeNotifierProvider.value(
      value: firebaseProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // You can customize your theme here
      ),
      home: MyHomePage(userId: 'abc1'), // Replace with actual user ID logic
      debugShowCheckedModeBanner: false,
    );
  }
}