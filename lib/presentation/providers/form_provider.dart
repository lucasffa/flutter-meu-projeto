// lib/presentation/providers/form_provider.dart
import 'package:flutter/material.dart';

enum FormFieldType { text, email, password, phone, number }

class FormFieldState {
  FormFieldState({
    this.value = '',
    this.isValid = true,
    this.errorMessage,
    this.isDirty = false,
    this.isFocused = false,
  });

  final String value;
  final bool isValid;
  final String? errorMessage;
  final bool isDirty;
  final bool isFocused;

  FormFieldState copyWith({
    String? value,
    bool? isValid,
    String? errorMessage,
    bool? isDirty,
    bool? isFocused,
  }) {
    return FormFieldState(
      value: value ?? this.value,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      isDirty: isDirty ?? this.isDirty,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}

class FormProvider extends ChangeNotifier {
  final Map<String, FormFieldState> _fields = {};
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  final Map<String, FormFieldValidator<String>?> _validators = {};

  bool _isSubmitting = false;
  bool _autoValidate = false;

  // Getters
  bool get isSubmitting => _isSubmitting;
  bool get autoValidate => _autoValidate;
  bool get isValid => _fields.values.every((field) => field.isValid);
  bool get isDirty => _fields.values.any((field) => field.isDirty);

  Map<String, String> get values {
    return Map.fromEntries(
      _fields.entries.map((entry) => MapEntry(entry.key, entry.value.value)),
    );
  }

  // Initialize field
  void initializeField(
    String fieldName, {
    String initialValue = '',
    FormFieldValidator<String>? validator,
  }) {
    if (!_fields.containsKey(fieldName)) {
      _fields[fieldName] = FormFieldState(value: initialValue);
      _controllers[fieldName] = TextEditingController(text: initialValue);
      _focusNodes[fieldName] = FocusNode();
      _validators[fieldName] = validator;

      // Add listeners
      _controllers[fieldName]!.addListener(() {
        updateField(fieldName, _controllers[fieldName]!.text);
      });

      _focusNodes[fieldName]!.addListener(() {
        updateFieldFocus(fieldName, _focusNodes[fieldName]!.hasFocus);
      });
    }
  }

  // Get controller for field
  TextEditingController? getController(String fieldName) {
    return _controllers[fieldName];
  }

  // Get focus node for field
  FocusNode? getFocusNode(String fieldName) {
    return _focusNodes[fieldName];
  }

  // Get field state
  FormFieldState? getFieldState(String fieldName) {
    return _fields[fieldName];
  }

  // Update field value
  void updateField(String fieldName, String value) {
    if (!_fields.containsKey(fieldName)) return;

    final currentState = _fields[fieldName]!;
    final validator = _validators[fieldName];
    
    String? errorMessage;
    bool isValid = true;

    // Validate if auto-validate is enabled or field is dirty
    if (_autoValidate || currentState.isDirty) {
      errorMessage = validator?.call(value);
      isValid = errorMessage == null;
    }

    _fields[fieldName] = currentState.copyWith(
      value: value,
      isDirty: true,
      isValid: isValid,
      errorMessage: errorMessage,
    );

    notifyListeners();
  }

  // Update field focus
  void updateFieldFocus(String fieldName, bool isFocused) {
    if (!_fields.containsKey(fieldName)) return;

    final currentState = _fields[fieldName]!;
    
    // If losing focus and field is dirty, validate
    if (!isFocused && currentState.isDirty) {
      validateField(fieldName);
    }

    _fields[fieldName] = currentState.copyWith(isFocused: isFocused);
    notifyListeners();
  }

  // Validate specific field
  bool validateField(String fieldName) {
    if (!_fields.containsKey(fieldName)) return true;

    final currentState = _fields[fieldName]!;
    final validator = _validators[fieldName];
    
    final errorMessage = validator?.call(currentState.value);
    final isValid = errorMessage == null;

    _fields[fieldName] = currentState.copyWith(
      isValid: isValid,
      errorMessage: errorMessage,
      isDirty: true,
    );

    notifyListeners();
    return isValid;
  }

  // Validate all fields
  bool validateAll() {
    bool allValid = true;
    
    for (final fieldName in _fields.keys) {
      final isFieldValid = validateField(fieldName);
      if (!isFieldValid) {
        allValid = false;
      }
    }

    _autoValidate = true;
    notifyListeners();
    
    return allValid;
  }

  // Clear field error
  void clearFieldError(String fieldName) {
    if (!_fields.containsKey(fieldName)) return;

    final currentState = _fields[fieldName]!;
    _fields[fieldName] = currentState.copyWith(
      errorMessage: null,
      isValid: true,
    );

    notifyListeners();
  }

  // Clear all errors
  void clearAllErrors() {
    for (final fieldName in _fields.keys) {
      clearFieldError(fieldName);
    }
  }

  // Set field value programmatically
  void setFieldValue(String fieldName, String value) {
    if (_controllers.containsKey(fieldName)) {
      _controllers[fieldName]!.text = value;
    }
    updateField(fieldName, value);
  }

  // Get field value
  String getFieldValue(String fieldName) {
    return _fields[fieldName]?.value ?? '';
  }

  // Set form as submitting
  void setSubmitting(bool isSubmitting) {
    _isSubmitting = isSubmitting;
    notifyListeners();
  }

  // Reset form
  void reset() {
    for (final controller in _controllers.values) {
      controller.clear();
    }
    
    for (final fieldName in _fields.keys) {
      _fields[fieldName] = FormFieldState();
    }
    
    _isSubmitting = false;
    _autoValidate = false;
    notifyListeners();
  }

  // Focus field
  void focusField(String fieldName) {
    if (_focusNodes.containsKey(fieldName)) {
      _focusNodes[fieldName]!.requestFocus();
    }
  }

  // Unfocus all fields
  void unfocusAll() {
    for (final focusNode in _focusNodes.values) {
      focusNode.unfocus();
    }
  }

  // Set auto validate
  void setAutoValidate(bool autoValidate) {
    _autoValidate = autoValidate;
    notifyListeners();
  }

  // Get error message for field
  String? getFieldError(String fieldName) {
    return _fields[fieldName]?.errorMessage;
  }

  // Check if field has error
  bool hasFieldError(String fieldName) {
    return _fields[fieldName]?.errorMessage != null;
  }

  // Check if field is valid
  bool isFieldValid(String fieldName) {
    return _fields[fieldName]?.isValid ?? true;
  }

  // Check if field is dirty
  bool isFieldDirty(String fieldName) {
    return _fields[fieldName]?.isDirty ?? false;
  }

  // Check if field is focused
  bool isFieldFocused(String fieldName) {
    return _fields[fieldName]?.isFocused ?? false;
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }
}