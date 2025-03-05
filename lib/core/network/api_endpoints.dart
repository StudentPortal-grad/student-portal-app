abstract class ApiEndpoints {
  static const String baseUrl = "http://192.168.1.7:8080/v1/";

  // Auth Endpoints
  static const String login = "auth/login";
  static const String signup = "auth/signup/initiate";
  static const String checkEmail = "auth/checkEmail";
  static const String forgetPassword = "auth/forgot-password";
  static const String verifyOtp = 'auth/verify-reset-otp';
  static const String verifyEmail = "auth/verifyEmail";
  static const String resetPassword = "auth/reset-password";
  static const String logout = "auth/logout";

  // User Endpoints
  static const String userProfile = "user/profile";

  static String updateUser(String id) => "api/v1/clients/$id";

// Other Services
}
