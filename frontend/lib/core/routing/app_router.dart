import 'package:flutter/material.dart';
import '../../features/auth/login_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';

class AppRouter {
  static const String dashboard = '/';
  static const String login = '/login';
  static const String patients = '/patients';
  static const String appointments = '/appointments';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
    dashboard: (_) => const DashboardScreen(),
    login: (_) => const LoginScreen(),
  };
}
