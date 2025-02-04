import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_toast.dart';

class UrlLauncher {
  /// Launches a WhatsApp chat with the provided phone number and optional message.
  static Future<void> whatsApp(String phoneNumber, {String? message}) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
      query: message != null ? 'text=${Uri.encodeComponent(message)}' : null,
    );
    await _launchUri(uri);
  }

  /// Initiates a phone call to the given phone number.
  static Future<void> phoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launchUri(uri);
  }

  /// Opens the email client with the provided email address and optional content.
  static Future<void> email(String emailAddress, {String? subject, String? body}) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      }.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&'),
    );
    await _launchUri(uri);
  }

  /// Opens the provided website URL.
  static Future<void> website(String websiteUrl) async {
    final Uri uri = Uri.parse(websiteUrl);
    await _launchUri(uri);
  }

  /// A helper method to launch a URI.
  static Future<void> _launchUri(Uri uri) async {
    if (!await launchUrl(uri)) {
      CustomToast().showErrorToast(message: 'Could not launch $uri');
      throw Exception('Could not launch \$uri');
    }
  }
}
