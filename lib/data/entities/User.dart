class User {
  String? userId;
  String? name;
  String? token;

  User({required this.userId, required this.name, required this.token});

  @override
  String toString() => 'User(userId: $userId, name: $name, token: $token)';

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'name': name, 'token': token};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        userId: map['userId'] as String?,
        name: map['name'] as String?,
        token: map['token'] as String?
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              userId == other.userId &&
              name == other.name &&
              token == other.token;

  @override
  int get hashCode => Object.hash(userId, name, token);
}