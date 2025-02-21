import 'package:intl/intl.dart';

class Message {
  Message({
    this.from,
    this.to,
    this.message,
    this.files,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Message.fromJson(dynamic json) {
    from = json?['from'];
    to = json?['to'];
    message = json?['message'];
    if (json?['files'] != null) {
      files = [];
      json?['files']?.forEach((v) {
        files?.add(Media.fromJson(v));
      });
    }
    id = json?['_id'];
    final create = DateTime.tryParse(json?['createdAt'] ?? '');
    final update = DateTime.tryParse(json?['updatedAt'] ?? '');
    if (create != null) updatedAt = DateFormat.jm().format(create.toLocal());
    if (update != null) updatedAt = DateFormat.jm().format(update.toLocal());
  }

  String? from;
  String? to;
  String? message;
  List<Media>? files;
  String? id;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
    map['message'] = message;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  static List<Message> dummyData() {
    return [
      Message(from: '1', to: '0', message: 'Hii', files: [], id: '1'),
      Message(from: '0', to: '1', message: 'Hii', files: [], id: '1'),
      Message(from: '1', to: '0', message: 'How R U', files: [], id: '1'),
      Message(from: '0', to: '1', message: 'Fine', files: [], id: '1'),
    ];
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Message && other.runtimeType == runtimeType && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Media {
  Media({
    this.url,
    this.type,
    this.id,
  });

  Media.fromJson(dynamic json) {
    url = json['secure_url'];
    type = json['type'];
    id = json['_id'];
  }

  String? url;
  String? type;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['secure_url'] = url;
    map['type'] = type;
    map['_id'] = id;
    return map;
  }
}
