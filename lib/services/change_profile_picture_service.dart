import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../providers/firebaseProvider.dart';

class ProfilePictureService {
  static const String _storagePath = 'profile_pictures';
  static const int _maxSizeInBytes = 5 * 1024 * 1024; // 5MB
  static const List<String> _allowedExtensions = ['jpg', 'jpeg', 'png'];

  static Future<String?> uploadProfilePicture({
    required String userId,
    required File imageFile,
    required FirebaseProvider firebaseProvider,
  }) async {
    if (!_isFirebaseInitialized(firebaseProvider)) return null;
    if (!await _validateImage(imageFile)) return null;

    try {
      final String fileName = '$userId.jpg';
      final Reference storageRef = firebaseProvider.firebaseStorage!
          .ref()
          .child(_storagePath)
          .child(fileName);

      await storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final String downloadUrl = await storageRef.getDownloadURL();
      await _updateUserProfilePictureUrl(userId, downloadUrl, firebaseProvider);

      return downloadUrl;
    } catch (e) {
      print('Error uploading profile picture: $e');
      return null;
    }
  }

  static Future<String?> getProfilePictureUrl(
      String userId,
      FirebaseProvider firebaseProvider,
      ) async {
    if (!_isFirebaseInitialized(firebaseProvider)) return null;

    try {
      final ref = firebaseProvider.firebaseStorage!
          .ref()
          .child(_storagePath)
          .child('$userId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting profile picture URL: $e');
      return null;
    }
  }

  static Future<bool> deleteProfilePicture(
      String userId,
      FirebaseProvider firebaseProvider,
      ) async {
    if (!_isFirebaseInitialized(firebaseProvider)) return false;

    try {
      final ref = firebaseProvider.firebaseStorage!
          .ref()
          .child(_storagePath)
          .child('$userId.jpg');
      await ref.delete();

      await _updateUserProfilePictureUrl(userId, null, firebaseProvider);

      return true;
    } catch (e) {
      print('Error deleting profile picture: $e');
      return false;
    }
  }

  static Future<void> _updateUserProfilePictureUrl(
      String userId,
      String? url,
      FirebaseProvider firebaseProvider,
      ) async {
    await firebaseProvider.firebaseFirestore!
        .collection('User')
        .doc(userId)
        .update({
      'profilePictureUrl': url,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  static Future<bool> _validateImage(File imageFile) async {
    try {
      final fileSize = await imageFile.length();
      if (fileSize > _maxSizeInBytes) {
        print('File size exceeds 5MB limit');
        return false;
      }

      final extension = imageFile.path.split('.').last.toLowerCase();
      if (!_allowedExtensions.contains(extension)) {
        print('Invalid file format. Allowed formats: JPG, JPEG, PNG');
        return false;
      }

      return true;
    } catch (e) {
      print('Error validating image: $e');
      return false;
    }
  }

  static bool _isFirebaseInitialized(FirebaseProvider firebaseProvider) {
    if (!firebaseProvider.isInitialized) {
      print('Firebase is not initialized');
      return false;
    }
    return true;
  }
}