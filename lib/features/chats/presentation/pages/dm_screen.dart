import 'package:flutter/material.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import '../widgets/message_field.dart';
import '../widgets/message_view.dart';
import '../../data/model/message.dart' as model;

class DmScreen extends StatelessWidget {
  const DmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (c, i) =>
                  MessageItemView(message: model.Message.dummyData()[i]),
              separatorBuilder: (BuildContext context, int index) =>
                  12.heightBox,
              itemCount: model.Message.dummyData().length,
            ),
          ),
          15.heightBox,
          MessageField(),
          15.heightBox,
        ],
      ),
    );
  }
}
