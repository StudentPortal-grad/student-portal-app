import 'error_model.dart';

class SocketFailure extends Failure {
  const SocketFailure({required super.message});

  factory SocketFailure.fromError(dynamic error) {
    final err = error?.toString() ?? 'Unknown socket error';
    if (err.contains('Invalid token') ||
        err.contains('Authentication error') ||
        err.contains('Token expired')) {
      return SocketFailure(message: 'Authentication failed or session expired');
    }
    if (err.contains('timed out')) {
      return SocketFailure(message: 'Socket connection timed out');
    }
    return SocketFailure(message: err);
  }
}
