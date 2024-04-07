import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trashtreasure_recycler/controller/language_controller.dart';
import 'package:trashtreasure_recycler/seller_authentication/login_page.dart';
import 'package:trashtreasure_recycler/seller_authentication/register_page.dart';
import 'package:trashtreasure_recycler/splash_screen/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? '';

  runApp(MyApp(locale: languageCode));
}

class MyApp extends StatelessWidget {
  final String locale;
  MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageChangeController()),
        ],
        child: Consumer<LanguageChangeController>(
            builder: (context, provider, child) {
          if (locale.isEmpty) {
            provider.changeLanguage(Locale('en'));
          }
          return MaterialApp(
            locale: locale == ''
                ? Locale('en')
                : provider.appLocale == null
                    ? Locale('en')
                    : provider.appLocale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: [Locale('en'), Locale('ne')],
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
            routes: {
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
              '/splash': (context) => SplashPage(),
            },
          );
        }));
  }
}
