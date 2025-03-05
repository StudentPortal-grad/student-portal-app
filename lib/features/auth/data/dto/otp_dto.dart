class OtpDto {
  final String? pinCode;
  final String? email;

  OtpDto({this.pinCode, this.email});

  toJson() => {"otp": pinCode, "email": email};
}
