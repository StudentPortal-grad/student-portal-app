abstract class ApiEndpoints {
  static const String host = "http://192.168.1.7:8080";
  static const String version = "/v1/";

  static String baseUrl = host + version;

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
  static const String changePassword = "users/me/password";

  // Messaging Endpoints
  static const String conversations = "conversations";

  // Events Endpoints
  static const String events = "events";
  static String eventID(String id) => "events/$id";
  static String eventRSVP(String id) => "events/$id/rsvp";

  // discussions and posts
  static const String discussions = "discussions";
}
