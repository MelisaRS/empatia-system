import 'package:flutter/material.dart';

import 'app/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empatía',
      theme: AppTheme.lightTheme,
      routes: AppRouter.routes,
    );
  }
}
