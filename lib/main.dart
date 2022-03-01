import 'dart:io';
import 'package:e_com/provider/google_sign_in.dart';
import 'package:e_com/widget/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Pages/splash_page.dart';
import 'changelanguage.dart';
import 'core/store.dart';
import 'dart:async';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();

  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInProvider>(
        create: (context) => GoogleSignInProvider(),
        child: ChangeNotifierProvider<ChangeLaanguage>(
          create: (context) => ChangeLaanguage(),
          child: Builder(
              builder: (context) => MaterialApp(
                    themeMode: ThemeMode.system,
                    theme: MyTheme.lightTheme(context),
                    darkTheme: MyTheme.darkTheme(context),
                    locale: Provider.of<ChangeLaanguage>(context, listen: true)
                        .currentlocale,
                    localizationsDelegates: [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      Locale("en", "US"),
                      Locale("ar", "Arabic"),
                    ],
                    debugShowCheckedModeBanner: false,
                    title: 'Sinbad',
                    home: SplashPage(),
                  )),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
