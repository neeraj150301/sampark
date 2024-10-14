import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String user;
  final void Function()? onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user),
        onTap: onTap,
      ),
    );
  }
}
