class User {
  String id;
  String username;
  String role;
  String rfidUid;
  String password;
  int createdAt;
  int updatedAt;

  User({
    required this.id,
    required this.username,
    required this.role,
    required this.rfidUid,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'rfid_uid': rfidUid,
      'password': password,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      role: map['role'],
      rfidUid: map['rfid_uid'],
      password: map['password'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
