import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/isar_provider.dart';
import 'core/router/app_router.dart';
import 'core/notifications/notification_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarInstance = await initIsar();
  final notificationServiceInstance = NotificationService();
  await notificationServiceInstance.init();

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isarInstance),
        notificationServiceProvider.overrideWithValue(
          notificationServiceInstance,
        ),
      ],
      child: const CarCareApp(),
    ),
  );
}

class CarCareApp extends ConsumerWidget {
  const CarCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'CarCare',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Force premium light mode aesthetic
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
