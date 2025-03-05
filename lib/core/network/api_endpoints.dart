abstract class ApiEndpoints {
  static const String baseUrl = "http://192.168.1.7:8080/v1/";

  // Auth Endpoints
  static const String login = "auth/login";
  static const String signup = "auth/signup";
  static const String checkEmail = "auth/checkEmail";
  static const String forgetPassword = "auth/forgot-password";
  static const String verifyEmail = "auth/verifyEmail";
  static const String resetPassword = "auth/reset-password";
  static const String logout = "auth/logout";

  static String verifyForgetEmail(String pinCode) =>
      "api/v1/clients/auth/verifyForgotPassword/$pinCode";

  // User Endpoints
  static const String userProfile = "user/profile";

  static String updateUser(String id) => "api/v1/clients/$id";

// Other Services
}
