// lib/domain/entities/user_entity.dart
class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    this.avatar,
    this.role,
    this.permissions,
    this.isActive = true,
    this.createdAt,
    this.lastLoginAt,
  });

  final String id;
  final String username;
  final String email;
  final String? name;
  final String? avatar;
  final String? role;
  final List<String>? permissions;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  // Factory constructor for creating from JSON
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      permissions: json['permissions'] != null 
          ? List<String>.from(json['permissions'] as List)
          : null,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      lastLoginAt: json['last_login_at'] != null 
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
    );
  }

  // Convert to JSON
  String toJson() {
    return '''
{
  "id": "$id",
  "username": "$username",
  "email": "$email",
  "name": ${name != null ? '"$name"' : 'null'},
  "avatar": ${avatar != null ? '"$avatar"' : 'null'},
  "role": ${role != null ? '"$role"' : 'null'},
  "permissions": ${permissions != null ? '${permissions!.map((p) => '"$p"').toList()}' : 'null'},
  "is_active": $isActive,
  "created_at": ${createdAt?.toIso8601String() != null ? '"${createdAt!.toIso8601String()}"' : 'null'},
  "last_login_at": ${lastLoginAt?.toIso8601String() != null ? '"${lastLoginAt!.toIso8601String()}"' : 'null'}
}''';
  }

  // Copy with method for immutable updates
  UserEntity copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    String? avatar,
    String? role,
    List<String>? permissions,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  // Equality and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ username.hashCode ^ email.hashCode;
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, email: $email, name: $name)';
  }

  // Helper methods
  bool hasPermission(String permission) {
    return permissions?.contains(permission) ?? false;
  }

  bool hasRole(String targetRole) {
    return role == targetRole;
  }

  String get displayName {
    return name?.isNotEmpty == true ? name! : username;
  }

  String get initials {
    if (name?.isNotEmpty == true) {
      final parts = name!.split(' ');
      if (parts.length >= 2) {
        return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
      }
      return name![0].toUpperCase();
    }
    return username[0].toUpperCase();
  }
}