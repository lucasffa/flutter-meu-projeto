// lib/data/models/auth_model.dart
class ApiResponse {
  const ApiResponse({
    required this.isSuccess,
    this.data,
    this.errorMessage,
    this.statusCode,
  });

  final bool isSuccess;
  final Map<String, dynamic>? data;
  final String? errorMessage;
  final int? statusCode;

  factory ApiResponse.success(Map<String, dynamic> data, {int? statusCode}) {
    return ApiResponse(
      isSuccess: true,
      data: data,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.failure(String errorMessage, {int? statusCode}) {
    return ApiResponse(
      isSuccess: false,
      errorMessage: errorMessage,
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'ApiResponse.success(data: $data)';
    } else {
      return 'ApiResponse.failure(error: $errorMessage)';
    }
  }
}

class LoginRequest {
  const LoginRequest({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}

class LoginResponse {
  const LoginResponse({
    required this.user,
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.tokenType = 'Bearer',
  });

  final UserModel user;
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final String tokenType;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      tokenType: json['token_type'] as String? ?? 'Bearer',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
    };
  }
}

class UserModel {
  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'avatar': avatar,
      'role': role,
      'permissions': permissions,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'last_login_at': lastLoginAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
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
    return UserModel(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
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
    return 'UserModel(id: $id, username: $username, email: $email)';
  }
}

class RefreshTokenRequest {
  const RefreshTokenRequest({
    required this.refreshToken,
  });

  final String refreshToken;

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
    };
  }

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequest(
      refreshToken: json['refresh_token'] as String,
    );
  }
}

class ForgotPasswordRequest {
  const ForgotPasswordRequest({
    required this.email,
  });

  final String email;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequest(
      email: json['email'] as String,
    );
  }
}

class ErrorResponse {
  const ErrorResponse({
    required this.message,
    this.code,
    this.details,
  });

  final String message;
  final String? code;
  final Map<String, dynamic>? details;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String,
      code: json['code'] as String?,
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'details': details,
    };
  }

  @override
  String toString() {
    return 'ErrorResponse(message: $message, code: $code)';
  }
}