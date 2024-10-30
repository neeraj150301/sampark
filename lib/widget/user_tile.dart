import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String user;
  final String? profileImageUrl;
  final void Function()? onTap;

  const UserTile(
      {super.key,
      required this.user,
      required this.profileImageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    //   print(profileImageUrl);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: profileImageUrl != null
            ? CircleAvatar(
                radius: 18,
                // backgroundColor: Colors.grey.shade300,
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 38,
                    width: 38,
                    fit: BoxFit.cover,
                    imageUrl: profileImageUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              )

            // CircleAvatar(
            //     backgroundImage: NetworkImage(profileImageUrl!),
            //     radius: 18,
            //   )
            : CircleAvatar(
                radius: 18,
                child: Icon(Icons.person,
                    size: 30,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6)),
              ),
        title: Text(
          user,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
        trailing: Icon(Icons.chat_bubble_outline,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
      ),
    );
  }
}
