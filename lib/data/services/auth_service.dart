// lib/data/services/auth_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';

class AuthService {
  AuthService({
    this.baseUrl = 'https://api.ifood.com.br/v1',
    this.timeout = const Duration(seconds: 30),
  });

  final String baseUrl;
  final Duration timeout;

  // HTTP Client with timeout
  http.Client get _client => http.Client();

  Future<ApiResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.failure('Sem conexão com a internet');
    } on http.ClientException {
      return ApiResponse.failure('Erro de conexão');
    } catch (e) {
      return ApiResponse.failure('Erro inesperado: $e');
    }
  }

  Future<ApiResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/auth/refresh'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $refreshToken',
            },
            body: jsonEncode({
              'refresh_token': refreshToken,
            }),
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.failure('Sem conexão com a internet');
    } on http.ClientException {
      return ApiResponse.failure('Erro de conexão');
    } catch (e) {
      return ApiResponse.failure('Erro inesperado: $e');
    }
  }

  Future<ApiResponse> logout(String accessToken) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/auth/logout'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.failure('Sem conexão com a internet');
    } on http.ClientException {
      return ApiResponse.failure('Erro de conexão');
    } catch (e) {
      return ApiResponse.failure('Erro inesperado: $e');
    }
  }

  Future<ApiResponse> validateToken(String accessToken) async {
    try {
      final response = await _client
          .get(
            Uri.parse('$baseUrl/auth/validate'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.failure('Sem conexão com a internet');
    } on http.ClientException {
      return ApiResponse.failure('Erro de conexão');
    } catch (e) {
      return ApiResponse.failure('Erro inesperado: $e');
    }
  }

  Future<ApiResponse> getCurrentUser(String accessToken) async {
    try {
      final response = await _client
          .get(
            Uri.parse('$baseUrl/auth/me'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.failure('Sem conexão com a internet');
    } on http.ClientException {
      return ApiResponse.failure('Erro de conexão');
    } catch (e) {
      return ApiResponse.failure('Erro inesperado: $e');
    }
  }

  Future<ApiResponse> requestPasswordReset(String email) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/auth/forgot-password'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
            }),
          )
          .timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.failure('Sem conexão com a internet');
    } on http.ClientException {
      return ApiResponse.failure('Erro de conexão');
    } catch (e) {
      return ApiResponse.failure('Erro inesperado: $e');
    }
  }

  ApiResponse _handleResponse(http.Response response) {
    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      switch (response.statusCode) {
        case 200:
        case 201:
          return ApiResponse.success(data);

        case 400:
          return ApiResponse.failure(
            data['message'] ?? 'Dados inválidos',
          );

        case 401:
          return ApiResponse.failure(
            data['message'] ?? 'Credenciais inválidas',
          );

        case 403:
          return ApiResponse.failure(
            data['message'] ?? 'Acesso negado',
          );

        case 404:
          return ApiResponse.failure(
            data['message'] ?? 'Usuário não encontrado',
          );

        case 422:
          return ApiResponse.failure(
            _extractValidationErrors(data),
          );

        case 429:
          return ApiResponse.failure(
            'Muitas tentativas. Tente novamente mais tarde',
          );

        case 500:
          return ApiResponse.failure(
            'Erro interno do servidor',
          );

        case 502:
        case 503:
        case 504:
          return ApiResponse.failure(
            'Serviço temporariamente indisponível',
          );

        default:
          return ApiResponse.failure(
            data['message'] ?? 'Erro desconhecido (${response.statusCode})',
          );
      }
    } catch (e) {
      return ApiResponse.failure(
        'Erro ao processar resposta do servidor',
      );
    }
  }

  String _extractValidationErrors(Map<String, dynamic> data) {
    if (data['errors'] != null) {
      final errors = data['errors'] as Map<String, dynamic>;
      final firstError = errors.values.first;
      
      if (firstError is List && firstError.isNotEmpty) {
        return firstError.first.toString();
      }
      
      return firstError.toString();
    }
    
    return data['message'] ?? 'Dados inválidos';
  }

  void dispose() {
    _client.close();
  }
}