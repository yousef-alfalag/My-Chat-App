import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note/main.dart';
import 'package:note/view/screens/auth/login.dart';
import 'package:note/view/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => sharedPref.getBool('islogin') == null
              ? const LoginScreen()
              : const HomeScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [
          Color.fromARGB(255, 77, 14, 185),
          Color.fromARGB(255, 204, 26, 14),
        ])),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notes_outlined,
              color: Colors.white,
              size: 60,
              shadows: [Shadow(color: Colors.black)],
            ),
            Text(
              "Best Note App",
              style: TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
