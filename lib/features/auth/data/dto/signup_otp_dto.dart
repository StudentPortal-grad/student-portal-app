class SignupOtpDto {
  final String? email;
  final String? pinCode;

  SignupOtpDto({this.email, required this.pinCode});

  toJson() => {"code": pinCode};
}
