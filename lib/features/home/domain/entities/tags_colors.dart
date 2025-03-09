import 'package:flutter/material.dart';

class TagsColors {
  static const List<TagColor> tagsColors = [
    TagColor(Color(0xffFFEAD5), Color(0xff9C2A10)),
    TagColor(Color(0xffEBE9FE), Color(0xff6941C6)),
    TagColor(Color(0xffE9EAEB), Color(0xff252B37)),
    TagColor(Color(0xffD1FADF), Color(0xff05603A)),
  ];
}

class TagColor {
  final Color background;
  final Color text;

  const TagColor(this.background, this.text);
}
