import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'app.provider.dart';
import 'app.route.dart';
import 'core/theme/app.theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: AppProvider.providers,
          builder: (context, child) {
            final appRouter = context.read<AppRouter>().router;
            return MaterialApp.router(
              title: 'PetCare Express',
              darkTheme: AppTheme.darkTheme,
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              locale: const Locale('pt', 'BR'),
              supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // -----------------------------------
            );
          },
        );
      },
    );
  }
}
