import 'package:flutter/material.dart';

import '../../core/routing/app_routes.dart';
import '../../features/auth/login_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
    AppRoutes.dashboard: (_) => const DashboardScreen(),
    AppRoutes.login: (_) => const LoginScreen(),
  };
}
