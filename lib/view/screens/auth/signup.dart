import 'package:flutter/material.dart';
import 'package:note/main.dart';
import 'package:note/services/services.dart';
import 'package:note/view/screens/auth/login.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:note/view/widgets/custom_button.dart';
import 'package:note/view/widgets/custom_textfeild.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Services services = Services();
    // InitialServices initialServices = InitialServices();
    signUp() async {
      try {
        await services.singUp(emailController.text, passwordController.text);
        // await initialServices.sharedPreferences.setBool("islogin", true);
        // initialServices.islogin =
        //     await initialServices.sharedPreferences.getBool("islogin")!;
        sharedPref.setBool("islogin", true);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
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
          CustomTextFeild(controller: passwordController, hinttext: "Password"),
          CustomButton(
              onPressed: () async {
                await signUp();
              },
              buttonName: "Regester"),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("I already have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  child: const Text(" Login ")),
            ],
          )
        ],
      )),
    );
  }
}
