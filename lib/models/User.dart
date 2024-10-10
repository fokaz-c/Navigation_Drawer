import 'dart:core';

class User{
  final String role;
  final String institute;
  final bool readyForHire;
  final String? profilePicture;

  User({
    required this.role,
    required this.institute,
    this.readyForHire = false,
    this.profilePicture
  });
}