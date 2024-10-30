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
        // backgroundColor: Colors.black,
        title: Text(isImageMessage ? 'Chat Image' : 'Profile Image'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedNetworkImage(
            // filterQuality: FilterQuality.high,
            // height: 38,
            // width: 38,
            fit: BoxFit.contain,
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
