import 'package:flutter/material.dart';
import '../../core/routing/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.dashboard);
              },
              child: const Text('Volver a Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
