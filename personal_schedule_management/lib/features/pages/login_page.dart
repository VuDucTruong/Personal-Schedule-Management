import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
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
                body: Column(
                  children: [
                    //Background
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage(
                                'lib/images/loginView_background.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Row(children: [
                                //App logo
                                Flexible(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.outline,
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          3), // Border radius
                                      child: ClipOval(
                                          child: Image.asset(
                                              'lib/images/app_logo.png')),
                                    ),
                                  ),
                                ),
                                //App name
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              width: 3)),
                                      child: Text("<appname>",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                              )),
                                    ),
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Row(children: [
                        //Greeting
                        Text("Chào Bạn!",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                )),
                      ]),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    //Username TextField
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.outline),
                                borderRadius: BorderRadius.circular(32)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                borderRadius: BorderRadius.circular(32)),
                            hintText: "Tên đăng nhập",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          obscureText: false,
                        ),
                      ),
                    ),
                    //Password TextField
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                                  borderRadius: BorderRadius.circular(32)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                  borderRadius: BorderRadius.circular(32)),
                              hintText: "Mật khẩu",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ),
                    ),
                    //Forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Quên mật khẩu?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                            ),
                          ]),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    //login button
                    Flexible(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 20),
                          foregroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          side: BorderSide(
                            width: 3,
                            color: Theme.of(context).colorScheme.primary,
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
                    ),
                    //Sign up
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chưa có tài khoản? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              Text(
                                "Đăng kí ngay",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                              )
                            ]),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
