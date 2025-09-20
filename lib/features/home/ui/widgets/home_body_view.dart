import 'package:flutter/material.dart';

import 'home_header_bar.dart';

class HomeBodyView extends StatelessWidget {
  const HomeBodyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: CustomScrollView(slivers: [HomeHeaderBar()]),
    );
  }
}
