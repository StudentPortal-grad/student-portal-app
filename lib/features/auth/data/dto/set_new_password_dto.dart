class SetNewPasswordDto {
  final String password;
  final String token;

  SetNewPasswordDto({required this.password, required this.token});

  toJson(){
    return {
      "password": password,
      "resetToken": token
    };
  }
}
