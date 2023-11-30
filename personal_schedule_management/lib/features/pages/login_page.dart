import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/pages/changepass_page.dart';
import 'package:personal_schedule_management/features/pages/register_page.dart';
import 'package:personal_schedule_management/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email textfield
  final emailController = TextEditingController();
  bool firstEnterEmailTF = false;
  FocusNode emailFocus = FocusNode();

  //password textfield
  final passwordController = TextEditingController();
  bool firstEnterPasswordTF = false;
  bool passwordVisible = false;
  FocusNode passwordFocus = FocusNode();

  //Error text
  String errorText = "";

  //Validate
  // String? validateEmail(String value) {
  //   String? errorText;
  //   if (!firstEnterEmailTF) {
  //     return null;
  //   } else {
  //     if (value.isEmpty) {
  //       emailIsCorrect = false;
  //       errorText = "Vui lòng nhập Email";
  //     } else if (!EmailValidator.validate(value)) {
  //       emailIsCorrect = false;
  //       errorText = "Email không hợp lệ";
  //     } else {
  //       emailIsCorrect = true;
  //     }
  //   }
  //   return emailFocus.hasFocus ? null : errorText;
  // }

  // String? validatePassword(String value) {
  //   String? errorText;
  //   if (!firstEnterPasswordTF) {
  //     return null;
  //   } else {
  //     if (value.isEmpty) {
  //       passwordIsCorrect = false;
  //       errorText = "Vui lòng nhập mật khẩu";
  //     } else if (value.length < 8) {
  //       passwordIsCorrect = false;
  //       errorText = "Mật khẩu phải từ 8 kí tự trở lên";
  //     } else {
  //       passwordIsCorrect = true;
  //     }
  //   }
  //   return passwordFocus.hasFocus ? null : errorText;
  // }

  Future signInButtonPressed(BuildContext context) async {
    setState(() {
      firstEnterEmailTF = true;
      firstEnterPasswordTF = true;
      emailFocus.unfocus();
      passwordFocus.unfocus();
    });
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    if (await signIn(context)) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
      );
    } else {
      setState(() {
        errorText = "Tài khoản hoặc mật khẩu không chính xác!";
      });
    }
  }

  Future<bool> signIn(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);
    } on FirebaseAuthException {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return false;
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    return true;
  }

  void forgetPasswordTextTapped(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ChangePassPage()));
  }

  void signUpTextTapped(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  void initState() {
    passwordVisible = false;
    firstEnterEmailTF = false;
    firstEnterPasswordTF = false;
    errorText = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
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
              resizeToAvoidBottomInset: true,
              body: Stack(
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
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(42),
                            topLeft: Radius.circular(42)),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      width: MediaQuery.of(context).size.width,
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
                          //Email TextField
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
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  onTap: () => {firstEnterEmailTF = true},
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
                                        const Icon(Icons.email_outlined),
                                    helperText: " ",
                                    // errorText: validateEmail(
                                    //     emailController.value.text),
                                  ),
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
                                  focusNode: passwordFocus,
                                  onTap: () => {firstEnterPasswordTF = true},
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
                                    prefixIcon: const Icon(Icons.lock_outlined),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                      child: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    // helperText: " ",
                                    // errorText: validatePassword(
                                    //     passwordController.value.text),
                                  ),
                                  obscureText: !passwordVisible,
                                  obscuringCharacter: '*',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 10),
                            child: Row(
                              children: [
                                Text(
                                  errorText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          fontStyle: FontStyle.italic),
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
                                          ..onTap = () {
                                            forgetPasswordTextTapped(context);
                                          }),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
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
                                onPressed: () {
                                  signInButtonPressed(context);
                                },
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
                                              ..onTap = () {
                                                signUpTextTapped(context);
                                              })
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
    );
  }
}
