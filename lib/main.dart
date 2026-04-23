import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/init_db_native.dart'
    if (dart.library.html) 'database/init_db_web.dart';
import 'providers/cycle_provider.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  await NotificationService.instance.initialize();
  runApp(const CrestApp());
}

class CrestApp extends StatelessWidget {
  const CrestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CycleProvider()..initialize(),
      child: MaterialApp(
        title: 'Crest',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
