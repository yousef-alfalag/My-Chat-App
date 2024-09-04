import 'package:firebase_core/firebase_core.dart';
import 'package:note/firebase_options.dart';
import 'package:note/view/screens/auth/login.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialServices {
  late SharedPreferences sharedPreferences;
  bool islogin = false;
  Future<InitialServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return this;
  }

  isLogin<Widget>() {
    if (islogin) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
