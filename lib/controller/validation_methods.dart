class ValidationMethods {
  static String? validateCompanyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Company name is required";
    }
    if (value.length < 3) {
      return "Company name must be at least 3 characters";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  // static String? validatePhone(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Phone number is required';
  //   }
  //   String pattern = r'^(?:\+971|0)?5[0-9]{8}$';
  //   if (!RegExp(pattern).hasMatch(value.trim())) {
  //     return 'Enter a valid phone number';
  //   }
  //   return null;
  // }

  static String? validateTax(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Tax number is required";
    }
    if (value.length < 5) {
      return "Tax number must be at least 5 digits";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    final passRegEx = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$',
    );
    if (!passRegEx.hasMatch(value)) {
      return "Password must be 8+ chars, include upper, lower, digit & special char";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
