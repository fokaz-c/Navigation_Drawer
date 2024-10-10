import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/firebaseProvider.dart';
import 'package:provider/provider.dart';

import 'customWidgets/navbar/studentNavbar.dart';
import 'firebase_options.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      return FirebaseProvider();
    },
    builder: (context, child) {
      return MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {

  Future<void> initFirebase(BuildContext context) async {
   var firebaseApp =  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
   print("Done Initializing firebase\ninitializing firestore");
   var fs = FirebaseFirestore.instanceFor(app: firebaseApp);
   var fbp = Provider.of<FirebaseProvider>(context, listen: false);
   fbp.firebaseApp = firebaseApp;
   fbp.firebaseFirestore = fs;

   print("Firebase is ready!");

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nav Drawer Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: initFirebase(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage();
          }
          return const Text("Loading Firebase");
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  static bool isReady = false;
  final studentNavbar = StudentNavbar(
      userRole: 'Student',
      institution: 'NIT, Calicut',
      initialReadyForHire: false
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: studentNavbar.build(context),
      body: Center(
        child: Column(children: [
          TextButton(onPressed: () async {
            FirebaseProvider fb = Provider.of<FirebaseProvider>(context,listen: false);
            var fs = fb.firebaseFirestore;
            if(fs == null) {
              print("FS is null");
              return;
            }
            var coll = await fs.collection("User").get();
            print("object");
            for(var dd in coll.docs){
              print(dd.id);
            }

            await fs.collection("User").add({
              "role" : "Student",
              "institute": "NITA",
              "readyForHire": isReady
            });
          }, child: const Text("Add dummy data")),
          const Text('Main Content Area')],),
      ),
    );
  }
}
