import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget text;
  final void Function()? onPressed;

  const MyButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.6),
              Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4), // Adds a soft shadow
            ),
          ],
        ),
        child: Center(
          child: text,
        //     child: Text(
        //   text,
        //   style: TextStyle(
        //     fontSize: 19,
        //     fontWeight: FontWeight.bold,
        //     color: Theme.of(context).colorScheme.primary.withOpacity(1),
        //     letterSpacing: 1.2,
        //   ),
        // )
        ),
      ),
    );
  }
}
