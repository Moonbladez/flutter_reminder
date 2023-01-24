import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Add Reminder'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Add List'),
          )
        ],
      ),
    );
  }
}
