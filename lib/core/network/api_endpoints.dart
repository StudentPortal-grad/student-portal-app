abstract class ApiEndpoints {
  static const String baseUrl = "http://192.168.1.7:8080/v1/";

  // Auth Endpoints
  static const String login = "auth/login";
  static const String signup = "auth/signup/initiate";
  static const String resendVerification = "auth/resend-verification";
  static const String forgetPassword = "auth/forgot-password";
  static const String verifyOtp = 'auth/verify-reset-otp';
  static const String verifyEmail = "auth/verify-email";
  static const String resetPassword = "auth/reset-password";
  static const String completeProfile = "auth/signup/complete";
  static const String logout = "auth/logout";

  // User Endpoints
  static const String myProfile = "users/me";
  static String getUserProfile(String userId) => "users/$userId";
  static String changePassword = "users/me/password";

  // Messaging Endpoints
  static const String conversations = "conversations";
}
