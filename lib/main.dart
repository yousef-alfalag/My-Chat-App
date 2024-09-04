import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note/firebase_options.dart';
import 'package:note/view/screens/auth/login.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:note/view/screens/splash_screen.dart';
import 'package:note/view/screens/test_clean_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  //await InitialServices().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen()
        // TestCleanScreen()
        //sharedPref.getBool("islogin") == null ? LoginScreen() : HomeScreen()
        // InitialServices().isLogin(),
        );
  }
}
