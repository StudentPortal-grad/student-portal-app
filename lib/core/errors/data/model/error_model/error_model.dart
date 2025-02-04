import 'package:equatable/equatable.dart';

import 'args.dart';

class Failure extends Equatable {
  final String? name;
  final String? error;
  final String? stack;
  final int? status;
  final bool? success;
  final Args? args;

  const Failure({
    this.name,
    this.error,
    this.stack,
    this.status,
    this.success,
    this.args,
  });

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        name: json['name'] as String?,
        error: json['error'] as String?,
        stack: json['stack'] as String?,
        status: json['status'] as int?,
        success: json['success'] as bool?,
        args: json['args'] == null
            ? null
            : Args.fromJson(json['args'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'error': error,
        'stack': stack,
        'status': status,
        'success': success,
        'args': args?.toJson(),
      };

  @override
  List<Object?> get props => [name, error, stack, status, success, args];
}
