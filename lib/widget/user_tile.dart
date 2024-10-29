import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String user;
  final String? profileImageUrl;
  final void Function()? onTap;

  const UserTile({super.key, required this.user, required this.profileImageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: profileImageUrl != null ? CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl!),
                radius: 20,
              ) : Icon(Icons.person,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
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
