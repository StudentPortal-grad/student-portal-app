class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
        .hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static String? validateEmail(String value) {
    RegExp regex =
        RegExp(r"^[a-zA-Z\d.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z\d-]+.[a-zA-Z\d-]+$");
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Please enter valid email';
      } else {
        return null;
      }
    }
  }

  static String? validatePassword(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Please enter password';
    } else {
      if (value.length < 8) {
        return 'password length should be at least 8';
      } else if (RegExp(r'^(?=.[a-z])(?=.[A-Z])(?=.\d)[A-Za-z\d]{8,}$')
          .hasMatch(value)) {
        return 'password length should include special characters';
      } else if (RegExp(
              r'^(?=.[a-z])(?=.[A-Z])(?=.[@$!%?&])[A-Za-z\d@$!%?&]{8,}$')
          .hasMatch(value)) {
        return 'password length should include numbers';
      } else if (RegExp(r'^(?=.[a-z])(?=.\d)(?=.[@$!%?&])[A-Za-z\d@$!%?&]{8,}$')
          .hasMatch(value)) {
        return 'password length should include capital characters';
      } else if (RegExp(r'^(?=.[A-Z])(?=.\d)(?=.[@$!%?&])[A-Za-z\d@$!%?&]{8,}$')
          .hasMatch(value)) {
        return 'password length should include small characters';
      } else {
        return null;
      }
    }
  }

  static List<bool> checkPasswordStrength(String value) {
    List<bool> strengthCriteria = [
      value.length >= 8,
      value.contains(RegExp(r'[A-Z]')),
      value.contains(RegExp(r'[a-z]')),
      value.contains(RegExp(r'[0-9]')),
      value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    ];

    return strengthCriteria;
  }
}
