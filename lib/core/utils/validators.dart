// lib/core/utils/validators.dart
class AppValidators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Digite um e-mail válido';
    }
    
    return null;
  }

  static String? Function(String?) minLength(int min) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo é obrigatório';
      }
      
      if (value.trim().length < min) {
        return 'Mínimo de $min caracteres';
      }
      
      return null;
    };
  }

  static String? Function(String?) maxLength(int max) {
    return (String? value) {
      if (value != null && value.length > max) {
        return 'Máximo de $max caracteres';
      }
      return null;
    };
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    
    return null;
  }

  static String? Function(String?) confirmPassword(String originalPassword) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo é obrigatório';
      }
      
      if (value != originalPassword) {
        return 'As senhas não coincidem';
      }
      
      return null;
    };
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    // Remove caracteres não numéricos
    final numbersOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (numbersOnly.length < 10 || numbersOnly.length > 11) {
      return 'Digite um telefone válido';
    }
    
    return null;
  }

  static String? cpf(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    // Remove caracteres não numéricos
    final numbersOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (numbersOnly.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    
    // Validação básica de CPF
    if (!_isValidCPF(numbersOnly)) {
      return 'CPF inválido';
    }
    
    return null;
  }

  static String? cnpj(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    // Remove caracteres não numéricos
    final numbersOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (numbersOnly.length != 14) {
      return 'CNPJ deve ter 14 dígitos';
    }
    
    // Validação básica de CNPJ
    if (!_isValidCNPJ(numbersOnly)) {
      return 'CNPJ inválido';
    }
    
    return null;
  }

  static String? numeric(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    
    if (double.tryParse(value) == null) {
      return 'Digite apenas números';
    }
    
    return null;
  }

  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  static bool _isValidCPF(String cpf) {
    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    
    int firstDigit = 11 - (sum % 11);
    if (firstDigit >= 10) firstDigit = 0;
    
    if (int.parse(cpf[9]) != firstDigit) {
      return false;
    }

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    
    int secondDigit = 11 - (sum % 11);
    if (secondDigit >= 10) secondDigit = 0;
    
    return int.parse(cpf[10]) == secondDigit;
  }

  static bool _isValidCNPJ(String cnpj) {
    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      return false;
    }

    // Lista de multiplicadores para o primeiro dígito
    const firstMultipliers = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(cnpj[i]) * firstMultipliers[i];
    }
    
    int firstDigit = sum % 11;
    firstDigit = firstDigit < 2 ? 0 : 11 - firstDigit;
    
    if (int.parse(cnpj[12]) != firstDigit) {
      return false;
    }

    // Lista de multiplicadores para o segundo dígito
    const secondMultipliers = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 13; i++) {
      sum += int.parse(cnpj[i]) * secondMultipliers[i];
    }
    
    int secondDigit = sum % 11;
    secondDigit = secondDigit < 2 ? 0 : 11 - secondDigit;
    
    return int.parse(cnpj[13]) == secondDigit;
  }
}