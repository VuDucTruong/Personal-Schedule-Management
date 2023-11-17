import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signInButtonPressed() {} //TODO: logic signin button
  void forgetPasswordTextTapped() {} //TODO: Logic forgot password
  void signUpTextTapped() {} //TODO: Logic signup text

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('vi'),
        ],
        locale: const Locale('vi'),
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: GoogleFonts.robotoTextTheme()),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: GoogleFonts.robotoTextTheme()),
        home: SafeArea(
          child: Builder(
            builder: (context) => Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                  child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/login_background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 130,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text(
                              "ĐĂNG NHẬP",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(children: [
                              //Greeting
                              Text("Chào Bạn!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontStyle: FontStyle.italic)),
                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          //Username TextField
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Email",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      hintText: "Email",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                      prefixIcon:
                                          const Icon(Icons.email_outlined)),
                                  obscureText: false,
                                ),
                              ],
                            ),
                          ),
                          //Password TextField
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Mật khẩu",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      hintText: "Mật khẩu",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                      prefixIcon:
                                          const Icon(Icons.lock_outlined)),
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                ),
                              ],
                            ),
                          ),
                          //Forgot password
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: "Quên mật khẩu?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = forgetPasswordTextTapped),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          //login button
                          Column(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20),
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  side: BorderSide(
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                onPressed: signInButtonPressed,
                                child: Text(
                                  "ĐĂNG NHẬP",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: "Chưa có tài khoản? "),
                                        TextSpan(
                                            text: "Đăng kí ngay!",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = signUpTextTapped)
                                      ]),
                                ),
                              ),
                            ],
                            //Sign up
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
        ));
  }
}
