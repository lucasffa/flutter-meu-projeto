// lib/domain/usecases/login_usecase.dart
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginResult {
  const LoginResult({
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

  factory LoginResult.success({
    required UserEntity user,
    required String accessToken,
    String? refreshToken,
  }) {
    return LoginResult(
      isSuccess: true,
      user: user,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory LoginResult.failure(String errorMessage) {
    return LoginResult(
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }
}

class LoginUseCase {
  const LoginUseCase({
    required AuthRepository repository,
  }) : _repository = repository;

  final AuthRepository _repository;

  Future<LoginResult> execute({
    required String username,
    required String password,
  }) async {
    try {
      // Validate input
      final validationError = _validateInput(username, password);
      if (validationError != null) {
        return LoginResult.failure(validationError);
      }

      // Normalize username (trim spaces, convert to lowercase for email)
      final normalizedUsername = _normalizeUsername(username);

      // Attempt login through repository
      final result = await _repository.login(
        username: normalizedUsername,
        password: password,
      );

      if (result.isSuccess) {
        return LoginResult.success(
          user: result.user!,
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken,
        );
      } else {
        return LoginResult.failure(
          _mapErrorMessage(result.errorMessage),
        );
      }
    } catch (e) {
      return LoginResult.failure(
        'Erro de conexão. Verifique sua internet e tente novamente.',
      );
    }
  }

  String? _validateInput(String username, String password) {
    if (username.trim().isEmpty) {
      return 'Nome de usuário é obrigatório';
    }

    if (password.isEmpty) {
      return 'Senha é obrigatória';
    }

    if (password.length < 3) {
      return 'Senha deve ter pelo menos 3 caracteres';
    }

    // Additional username validation
    if (username.trim().length < 3) {
      return 'Nome de usuário deve ter pelo menos 3 caracteres';
    }

    return null;
  }

  String _normalizeUsername(String username) {
    final trimmed = username.trim();
    
    // If it looks like an email, convert to lowercase
    if (trimmed.contains('@')) {
      return trimmed.toLowerCase();
    }
    
    return trimmed;
  }

  String _mapErrorMessage(String? originalError) {
    if (originalError == null) {
      return 'Erro desconhecido';
    }

    // Map common API errors to user-friendly messages
    switch (originalError.toLowerCase()) {
      case 'invalid_credentials':
      case 'unauthorized':
      case 'invalid_username_or_password':
        return 'Usuário ou senha inválidos';
      
      case 'user_not_found':
        return 'Usuário não encontrado';
      
      case 'account_disabled':
      case 'user_disabled':
        return 'Conta desabilitada. Contate o administrador';
      
      case 'account_locked':
        return 'Conta bloqueada. Tente novamente mais tarde';
      
      case 'too_many_attempts':
        return 'Muitas tentativas de login. Tente novamente em alguns minutos';
      
      case 'network_error':
      case 'connection_error':
        return 'Erro de conexão. Verifique sua internet';
      
      case 'server_error':
      case 'internal_server_error':
        return 'Erro no servidor. Tente novamente mais tarde';
      
      case 'maintenance':
        return 'Sistema em manutenção. Tente novamente mais tarde';
      
      default:
        // Return original error if it's already user-friendly
        if (originalError.length < 100 && !originalError.contains('_')) {
          return originalError;
        }
        return 'Erro ao fazer login. Tente novamente';
    }
  }
}