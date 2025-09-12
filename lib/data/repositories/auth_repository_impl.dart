// lib/data/repositories/auth_repository_impl.dart
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthService authService,
  }) : _authService = authService;

  final AuthService _authService;

  @override
  Future<AuthRepositoryResult> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _authService.login(
        username: username,
        password: password,
      );

      if (response.isSuccess) {
        final user = UserEntity.fromJson(response.data!['user']);
        return AuthRepositoryResult.success(
          user: user,
          accessToken: response.data!['access_token'],
          refreshToken: response.data?['refresh_token'],
        );
      } else {
        return AuthRepositoryResult.failure(
          response.errorMessage ?? 'Erro no login',
        );
      }
    } catch (e) {
      return AuthRepositoryResult.failure(
        'Erro de conexão',
      );
    }
  }

  @override
  Future<AuthRepositoryResult> refreshToken(String refreshToken) async {
    try {
      final response = await _authService.refreshToken(refreshToken);

      if (response.isSuccess) {
        final user = UserEntity.fromJson(response.data!['user']);
        return AuthRepositoryResult.success(
          user: user,
          accessToken: response.data!['access_token'],
          refreshToken: response.data?['refresh_token'],
        );
      } else {
        return AuthRepositoryResult.failure(
          response.errorMessage ?? 'Erro ao renovar token',
        );
      }
    } catch (e) {
      return AuthRepositoryResult.failure(
        'Erro de conexão',
      );
    }
  }

  @override
  Future<bool> logout(String accessToken) async {
    try {
      final response = await _authService.logout(accessToken);
      return response.isSuccess;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> validateToken(String accessToken) async {
    try {
      final response = await _authService.validateToken(accessToken);
      return response.isSuccess;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserEntity?> getCurrentUser(String accessToken) async {
    try {
      final response = await _authService.getCurrentUser(accessToken);
      
      if (response.isSuccess && response.data != null) {
        return UserEntity.fromJson(response.data!);
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> requestPasswordReset(String email) async {
    try {
      final response = await _authService.requestPasswordReset(email);
      return response.isSuccess;
    } catch (e) {
      return false;
    }
  }
}