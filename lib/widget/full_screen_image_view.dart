import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final bool isImageMessage;

  const FullScreenImagePage(
      {super.key, required this.imageUrl, required this.isImageMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text(isImageMessage ? 'Chat Image' : 'Profile Image'),
        centerTitle: true,
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            filterQuality: FilterQuality.high,
            // height: 38,
            // width: 38,
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          // Image.network(imageUrl),
        ),
      ),
    );
  }
}
