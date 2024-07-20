import 'dart:typed_data';

class ChatUser {
  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final String profilePicture;

  const ChatUser({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  factory ChatUser.fromJson(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
    );
  }

  ChatUser copyWith({
    String? id,
    String? email,
    String? userName,
    String? firstName,
    String? lastName,
    String? profilePicture,
  }) {
    return ChatUser(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
