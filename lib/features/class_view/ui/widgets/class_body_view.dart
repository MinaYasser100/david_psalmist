import 'package:flutter/material.dart';

class ClassBodyView extends StatelessWidget {
  const ClassBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text('Class Body View')),
        ),
      ],
    );
  }
}
