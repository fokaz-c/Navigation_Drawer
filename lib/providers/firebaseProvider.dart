import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProvider extends ChangeNotifier {
  FirebaseApp? firebaseApp;
  FirebaseFirestore? firebaseFirestore;
  FirebaseStorage? firebaseStorage;

  Future<void> initialize() async {
    firebaseApp = await Firebase.initializeApp();
    firebaseFirestore = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    notifyListeners();
  }

  bool get isInitialized => firebaseApp != null && firebaseFirestore != null && firebaseStorage != null;
}