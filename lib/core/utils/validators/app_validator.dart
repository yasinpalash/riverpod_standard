class AppValidator {
  AppValidator._();

  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final requiredError = requiredField(value, fieldName: 'Email');
    if (requiredError != null) {
      return requiredError;
    }

    final emailRegExp = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value!.trim())) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    final requiredError = requiredField(value, fieldName: 'Username');
    if (requiredError != null) {
      return requiredError;
    }

    if (value!.trim().length < 3) {
      return 'Username must be at least 3 characters.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final requiredError = requiredField(value, fieldName: 'Password');
    if (requiredError != null) {
      return requiredError;
    }

    if (value!.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
  ) {
    final requiredError = requiredField(value, fieldName: 'Confirm password');
    if (requiredError != null) {
      return requiredError;
    }

    if (value != originalPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final requiredError = requiredField(value, fieldName: 'Phone number');
    if (requiredError != null) {
      return requiredError;
    }

    final phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegExp.hasMatch(value!.trim())) {
      return 'Invalid phone number format.';
    }
    return null;
  }
}
