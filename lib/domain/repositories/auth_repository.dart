// lib/domain/repositories/auth_repository.dart
import '../entities/user_entity.dart';

class AuthRepositoryResult {
  const AuthRepositoryResult({
    required this.isSuccess,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.errorMessage,
  });

  final bool isSuccess;
  final UserEntity? user;
  final String? accessToken;
  final String? refreshToken;
  final String? errorMessage;

  factory AuthRepositoryResult.success({
    required UserEntity user,
    required String accessToken,
    String? refreshToken,
  }) {
    return AuthRepositoryResult(
      isSuccess: true,
      user: user,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory AuthRepositoryResult.failure(String errorMessage) {
    return AuthRepositoryResult(
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }
}

abstract class AuthRepository {
  Future<AuthRepositoryResult> login({
    required String username,
    required String password,
  });

  Future<AuthRepositoryResult> refreshToken(String refreshToken);

  Future<bool> logout(String accessToken);

  Future<bool> validateToken(String accessToken);

  Future<UserEntity?> getCurrentUser(String accessToken);

  Future<bool> requestPasswordReset(String email);
}