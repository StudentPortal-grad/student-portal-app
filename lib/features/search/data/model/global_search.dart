import 'package:student_portal/features/home/data/model/post_model/post.dart';
import 'package:student_portal/features/resource/data/model/resource.dart';

import '../../../events/data/models/event_model.dart';
import '../../../groups/data/models/user_sibling.dart';

class GlobalSearch {
  final List <Discussion>? discussions;
  final List <Resource>? resources;
  final List <UserSibling>? users;
  final List <Event>? events;

  GlobalSearch({this.discussions, this.resources, this.users, this.events});

  factory GlobalSearch.fromJson(Map<String, dynamic> json) => GlobalSearch(
    discussions: json["discussions"] == null ? null : List<Discussion>.from(json["discussions"].map((x) => Discussion.fromJson(x))),
    resources: json["resources"] == null ? null : List<Resource>.from(json["resources"].map((x) => Resource.fromJson(x))),
    users: json["users"] == null ? null : List<UserSibling>.from(json["users"].map((x) => UserSibling.fromJson(x))),
    events: json["events"] == null ? null : List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );
}