import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:student_portal/core/utils/secure_storage.dart';
import 'package:student_portal/core/utils/service_locator.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../features/auth/data/model/token_model/token_model.dart';
import '../errors/data/model/socket_failure.dart';
import '../network/api_endpoints.dart';
import '../repo/user_repository.dart';

class SocketService {
  static Socket? _socket;
  static bool _isInitialized = false;
  static const _retryDelay = Duration(seconds: 5);

  // Getter to ensure socket exists
  static Socket get socket {
    if (!_isInitialized) {
      assert(
        _socket != null,
        'SocketService not initialized. Call init() first.',
      );
    }
    return _socket!;
  }

  static Future<void> init({Duration timeout = const Duration(seconds: 10)}) async {
    if (_isInitialized && _socket != null && _socket!.connected) {
      _socket!.disconnect();
    }

    final completer = Completer<void>();

    try {
      final TokenModel? token = await getIt<SecureStorage>().readSecureData();
      log("TOKEN:: ${token?.accessToken}");
      _socket = io.io(
        ApiEndpoints.host,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'x-auth-token': token?.accessToken})
            .build(),
      );

      _setupEventHandlers(completer);

      _socket!.connect();

      await completer.future.timeout(timeout, onTimeout: () {
        _socket?.disconnect();
        throw SocketFailure(message: 'Socket connection timed out');
      });

      _isInitialized = true;
    } catch (e) {
      throw SocketFailure.fromError(e);
    }
  }
  static void _setupEventHandlers(Completer? completer) {
    _socket!.onConnect((_) {
      log('Socket connected');
      if (completer != null && !completer.isCompleted) {
        completer.complete();
      }
    });

    _socket!.onConnectError((error) {
      log('Socket connect error: $error');
      if (completer != null && !completer.isCompleted) {
        completer.completeError(SocketFailure.fromError(error));
      }
      _handleTokenErrorIfNeeded(error);
      _tryReconnect();
    });

    _socket!.onError((error) {
      log('Socket error: $error');
      _handleTokenErrorIfNeeded(error);
      _tryReconnect();
    });

    _socket!.onDisconnect((_) {
      log('Socket disconnected');
      _tryReconnect();
    });

    _socket!.onReconnect((_) {
      log('Socket reconnected');
    });
  }

  static void _tryReconnect() {
    Future.delayed(_retryDelay, () async {
      log("Attempting socket reconnection...");
      try {
        if (!_socket!.connected) {
          _socket!.connect();
        }
      } catch (e) {
        log("Reconnection attempt failed: $e");
        _tryReconnect();
      }
    });
  }


  static void _handleTokenErrorIfNeeded(dynamic error) {
    final err = error.toString();
    if (err.contains('Invalid token') || err.contains('Authentication error') || err.contains('Token expired')) {
      _handleTokenError();
    }
  }


  static void _handleTokenError() {
    log('Handling token error - disconnecting socket and invalidating token');
    disconnect();
    UserRepository.invalidToken();
    return;
  }

  static void emit(String event, {Object? message}) {
    log('Emitting event: $event with message: $message');
    socket.emit(event, message);
  }

  static void listen(String event, void Function(dynamic) callback) {
    if (socket.hasListeners(event)) {
      socket.off(event);
      log('Removed previous listener for event: $event');
    }
    socket.on(event, callback);
    log('Added listener for event: $event');
  }

  static void disconnect() {
    if (_isInitialized && _socket != null) {
      _socket!.disconnect();
      _isInitialized = false;
      log('Socket disconnected manually');
    }
  }
}

class SocketEvents {
  static const String getConversations = 'getConversations';
  static const String conversations = 'conversations';
  static const String sendMessage = 'sendMessage';
  static const String newMessage = 'newMessage';
  static const String messageSent = 'messageSent';
  static const String conversationStarted = 'conversationStarted';
}
