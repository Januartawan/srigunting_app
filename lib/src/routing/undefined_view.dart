import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String routeName;

  const UndefinedView({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Route for $routeName is not defined',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
