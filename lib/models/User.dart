class User {
  final String id;
  final String role;
  final String institution;
  final bool readyForHire;
  final String? profilePictureUrl;

  User({
    required this.id,
    required this.role,
    this.institution = '',
    this.readyForHire = false,
    this.profilePictureUrl,
  });

  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      role: data['role'] ?? 'guest',
      institution: data['institution'] ?? '',
      readyForHire: data['readyForHire'] ?? false,
      profilePictureUrl: data['profilePictureUrl'],
    );
  }

  factory User.guest() {
    return User(
      id: '',
      role: 'guest',
      institution: '',
      readyForHire: false,
      profilePictureUrl: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'institution': institution,
      'readyForHire': readyForHire,
      'profilePictureUrl': profilePictureUrl,
    };
  }

}
