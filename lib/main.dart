import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaad_hai/core/auth/supabase_config.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_router.dart';
import 'package:yaad_hai/core/services/language_service.dart';
import 'package:yaad_hai/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(url: Env.supabaseUrl, publishableKey: Env.supabaseAnonKey);
  await setupDependencies();
  runApp(const YaadHaiApp());
}

class YaadHaiApp extends StatelessWidget {
  const YaadHaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, _) => ListenableBuilder(
            listenable: locator<LanguageService>(),
            builder:
                (_, _) => MaterialApp.router(
                  title: 'YaadHai — Jo Padho, YaadHai.',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: ThemeMode.system,
                  routerConfig: appRouter,
                ),
          ),
    );
  }
}
