import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  final String text2;

  const Header({
    super.key,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.displayMedium,
        children: [
          TextSpan(text: text),
          TextSpan(
              text: text2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
