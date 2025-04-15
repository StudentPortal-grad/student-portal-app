import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:student_portal/core/utils/secure_storage.dart';
import 'package:student_portal/core/utils/service_locator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../features/auth/data/model/token_model/token_model.dart';
import '../network/api_endpoints.dart';

class SocketService {
  static Socket? _socket;
  static bool _isInitialized = false;

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

  static Future<void> init() async {
    if (_isInitialized && _socket != null && _socket!.connected) {
      log('Socket already connected, skipping initialization');
      return;
    }

    try {
      final TokenModel? token = await getIt<SecureStorage>().readSecureData();
      log('Initializing socket with token: ${token?.accessToken}');
      log("UserID: ${token?.id}");
      log("Host URL: ${ApiEndpoints.host}");

      _socket = IO.io(
        ApiEndpoints.host,
        IO.OptionBuilder()
            .setTransports(['websocket']) // Required for Flutter
            .disableAutoConnect() // connect manually
            .setExtraHeaders({
              'x-auth-token': token?.accessToken,
            })
            .build(),
      );

      _socket!.connect();
      _setupEventHandlers();
      _isInitialized = true;
    } catch (e) {
      log('Socket initialization error: $e');
      rethrow;
    }
  }

  static void _setupEventHandlers() {
    log('Setting up event handlers for socket');
    _socket!.onConnect((_) => log('Socket connected'));
    _socket!.onConnectError((error) => log('Connection error: $error'));
    _socket!.onDisconnect((_) => log('Socket disconnected'));
    _socket!.onError((error) => log('Socket error: $error'));
    _socket!.onReconnect((_) => log('Socket reconnected'));
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
