// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:batnf/Screens/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:batnf/Screens/completed_project.dart';
import 'package:batnf/Screens/events_center.dart';
import 'package:batnf/Screens/forget_password_page.dart';
import 'package:batnf/Screens/inprogress_project.dart';
import 'package:batnf/Screens/landing_page.dart';
import 'package:batnf/Screens/news.dart';
import 'package:batnf/Screens/projects.dart';
import 'package:batnf/Screens/reset_Completed_page.dart';
import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:batnf/Screens/signup.dart';
import 'package:batnf/Screens/welcone_page.dart';
import 'package:batnf/providers/completed_provider.dart';
import 'package:batnf/providers/event_provider.dart';
import 'package:batnf/providers/inprogress_provider.dart';
import 'package:batnf/providers/news_provider.dart';
import 'package:batnf/providers/pending_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/pending_project.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await Hive.initFlutter();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool exist = sharedPreferences.containsKey('autoLogin') &&
      sharedPreferences.containsKey('userId') &&
      sharedPreferences.containsKey('username');
  bool autoLogin = exist ? sharedPreferences.getBool('autoLogin')! : false;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  HttpOverrides.global = MyHttpoverrides();
  runApp(MyApp(autoLogin));
}

class MyApp extends StatelessWidget {
  final bool autoLogin;
  const MyApp(this.autoLogin, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InprogressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompletedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PendingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'BATNF',
        debugShowCheckedModeBanner: false,
        initialRoute: !autoLogin ? LandingPage.id : HomePage.id,
        routes: {
          LandingPage.id: (context) => const LandingPage(),
          WelcomePage.id: (context) => WelcomePage(),
          SignIn.id: (context) => SignIn(),
          HomePage.id: (context) => HomePage(),
          SignUp.id: (context) => SignUp(),
          ForgetPassword.id: (context) => ForgetPassword(),
          ResetPassword.id: (context) => ResetPassword(),
          ResetCompleted.id: (context) => ResetCompleted(),
          EventCenter.id: (context) => EventCenter(),
          ProjectPage.id: (context) => ProjectPage(),
          InprogressPage.id: (context) => InprogressPage(),
          CompletedPage.id: (context) => CompletedPage(),
          PendingPage.id: (context) => PendingPage(),
          News.id: (context) => News(),
        },
      ),
    );
  }
}
