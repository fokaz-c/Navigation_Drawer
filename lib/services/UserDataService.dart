import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/User.dart';
import '../providers/firebaseProvider.dart';

class UserDataService {
  static Future<User> fetchUserData(String? userId, FirebaseProvider firebaseProvider) async {
    if (userId == null || !firebaseProvider.isInitialized) {
      return User.guest();
    }

    try {
      DocumentSnapshot userDoc = await firebaseProvider.firebaseFirestore!
          .collection('User')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        print('User document does not exist. Returning guest user.'); // Debugging line
        return User.guest();
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      String? profilePictureUrl = await _getProfilePictureUrl(userId, firebaseProvider);

      userData['profilePictureUrl'] = profilePictureUrl;

      return User.fromMap(userId, userData);
    } catch (e) {
      print('Error fetching user data: $e'); // Debugging line
      return User.guest();
    }
  }

  static Future<String?> _getProfilePictureUrl(String userId, FirebaseProvider firebaseProvider) async {
    try {
      final ref = firebaseProvider.firebaseStorage!.ref('profile_pictures/$userId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error fetching profile picture: $e'); // Debugging line
      return null;
    }
  }
}
