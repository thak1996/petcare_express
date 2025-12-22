import 'package:flutter/material.dart';

class HeaderRegisterWidget extends StatelessWidget {
  const HeaderRegisterWidget({super.key, this.onPressed, this.title});

  final VoidCallback? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.arrow_back), onPressed: onPressed),
        Text(
          title ?? 'Title not found',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}
