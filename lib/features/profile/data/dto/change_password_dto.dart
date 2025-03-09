class ChangePasswordDto {
  final String currentPassword;
  final String newPassword;

  ChangePasswordDto({required this.currentPassword, required this.newPassword});

  toJson() => {'currentPassword': currentPassword, 'newPassword': newPassword};
}
