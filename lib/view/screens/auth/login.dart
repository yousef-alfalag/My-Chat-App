import 'package:flutter/material.dart';
import 'package:note/main.dart';
import 'package:note/services/services.dart';
import 'package:note/view/screens/auth/signup.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:note/view/widgets/custom_button.dart';
import 'package:note/view/widgets/custom_textfeild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Services services = Services();
    // InitialServices initialServices = InitialServices();
    login() async {
      try {
        await services.login(emailController.text, passwordController.text);
        // await initialServices.sharedPreferences.setBool("islogin", true);
        // InitialServices().islogin =
        //     await initialServices.sharedPreferences.getBool("islogin")!;
        sharedPref.setBool("islogin", true);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } on Exception catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepPurple),
              margin: const EdgeInsets.only(
                top: 25,
              ),
              child: const Icon(
                Icons.notes_outlined,
                color: Color.fromARGB(255, 247, 247, 247),
                size: 90,
                shadows: [Shadow(color: Colors.black)],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              child: const Text(
                  "sdfsddfesexzfdskjfk jflkdsjsfkjkjdslkfjsldj djflkjdsfsdasdsadsafjlkdsjglkdsjflksjflksdjklffjewfx,jffkldjioejlfkjdskldfskldfklsdjklfds"),
            ),
            CustomTextFeild(controller: emailController, hinttext: "Email"),
            CustomTextFeild(
                controller: passwordController, hinttext: "Password"),
            CustomButton(
                onPressed: () async {
                  await login();
                },
                buttonName: "Login"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("I don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                    },
                    child: const Text("Sign Up")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
