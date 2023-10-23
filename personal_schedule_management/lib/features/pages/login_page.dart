import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signInButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //Background
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('lib/images/loginView_background.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      const SizedBox(
                        width: 15,
                      ),
                      //App logo
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(3), // Border radius
                          child: ClipOval(
                              child: Image.asset('lib/images/app_logo.png')),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      //App name
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 35),
                        decoration: BoxDecoration(
                            color: lightColorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: lightColorScheme.primary, width: 3)),
                        child: const Text(
                          "<app name>",
                          style: AppTextStyle.h1,
                        ),
                      )
                    ])
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(children: [
                SizedBox(
                  width: 20,
                ),
                //Greeting
                Text(
                  "Chào Bạn!",
                  style: AppTextStyle.h1,
                ),
              ]),
              const SizedBox(
                height: 100,
              ),
              //Username TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: lightColorScheme.outline),
                          borderRadius: BorderRadius.circular(32)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: lightColorScheme.scrim),
                          borderRadius: BorderRadius.circular(32)),
                      hintText: "Tên đăng nhập"),
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Password TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: lightColorScheme.outline),
                          borderRadius: BorderRadius.circular(32)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: lightColorScheme.scrim),
                          borderRadius: BorderRadius.circular(32)),
                      hintText: "Mật khẩu"),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    "Quên mật khẩu?",
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.outline),
                  ),
                ]),
              ),
              const SizedBox(
                height: 70,
              ),
              //login button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  foregroundColor: Colors.black,
                  backgroundColor: lightColorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  side: BorderSide(
                    width: 3,
                    color: lightColorScheme.primary,
                  ),
                ),
                onPressed: signInButtonPressed,
                child: const Text(
                  "ĐĂNG NHẬP",
                  style: AppTextStyle.h2,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //Sign up
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Chưa có tài khoản? ",
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.outline),
                  ),
                  Text(
                    "Đăng kí ngay",
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.primary),
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
