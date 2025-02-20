import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_image_view.dart';

class ImagePostView extends StatelessWidget {
  const ImagePostView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Post",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: 'image$id',
              child: Center(
                child: CustomImageView(
                  materialNeeded: true,
                  imagePath: 'assets/images/dummy_image.png',
                      // 'https://www.news10.com/wp-content/uploads/sites/64/2024/11/674205c2471ac7.00644903.jpeg?w=960&h=540&crop=1',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'https://www.news10.com/wp-content/uploads/sites/64/2024/11/674205c2471ac7.00644903.jpeg?w=960&h=540&crop=1',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
