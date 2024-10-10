import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class FirebaseProvider extends ChangeNotifier{
  FirebaseApp? firebaseApp;
  FirebaseFirestore? firebaseFirestore;


}