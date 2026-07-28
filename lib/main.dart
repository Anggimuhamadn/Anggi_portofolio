import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Anggi Portfolio",
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
