abstract class ApiEndpoints {
  static const String baseUrl = "http://192.168.1.7:3000/";

  // Auth Endpoints
  static const String login = "api/v1/clients/auth/login";
  static const String signup = "api/v1/clients/auth/signup";
  static const String checkEmail = "api/v1/clients/auth/checkEmail";
  static const String forgetPassword = "api/v1/clients/auth/forgotPassword";

  static String verifyEmail(String pinCode) =>
      "api/v1/clients/auth/verifyEmail/$pinCode";

  static String verifyForgetEmail(String pinCode) =>
      "api/v1/clients/auth/verifyForgotPassword/$pinCode";

  static String resetPassword(String resetToken) =>
      "api/v1/clients/auth/resetPassword/$resetToken";

  // User Endpoints
  static const String userProfile = "$baseUrl/user/profile";

  static String updateUser(String id) => "api/v1/clients/$id";

// Other Services
}
