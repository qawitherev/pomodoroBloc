import 'package:flutter/material.dart';

class Vertical20 extends StatelessWidget {
  const Vertical20({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20,);
  }
}

class Vertical15 extends StatelessWidget {
  const Vertical15({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 15,);
  }
}

class Horizontal10 extends StatelessWidget {
  const Horizontal10({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 10,);
  }
}

class Horizontal15 extends StatelessWidget {
  const Horizontal15({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 15,);
  }
}

class CommonContainer10 extends StatelessWidget {
  final Widget child;
  const CommonContainer10({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width-10,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: theme.colorScheme.secondaryContainer,
      ),
      child: child,
    );
  }
}




