import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/pages/login_page.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});
  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  bool _SendSuccessful = false;

  // EMAIL
  final _EmailController = TextEditingController();
  FocusNode _EmailFocus = FocusNode();
  String? _EmailAuthError;
  String? _ExceptionText;

  // VALIDATING

  void _ResetPasswordButton (context) async {
    _EmailFocus.unfocus();

    // do something
    bool? result;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator()
          );
        }
    );

    result = await _resetPassword();

    if (result == true)
    {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //           content: Text('Gửi Email thành công. Hãy kiểm tra Email của bạn')
      //       );
      //     }
      // );
      _SendSuccessful = true;
    }
    else if (_ExceptionText != null)
    {
      String? message = _ExceptionText;
      _ExceptionText = null;


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.toString()))
      );
    }
    Navigator.of(context).pop();

    setState((){});
  }

  Future<bool> _resetPassword() async {
    try {
      bool testExist = await _checkIfEmailInUse(_EmailController.text.trim());
      if (!testExist)
      {
        _EmailAuthError = 'Email này chưa được đăng kí tài khoản';
        return false;
      }
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _EmailController.text.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
         _EmailAuthError = 'Email không hợp lệ';
      }
      // else if (e.code == 'user-not-found') {
      //   _EmailAuthError = 'Email này chưa được đăng kí tài khoản';
      // }
      else
      {
        _ExceptionText = e.message;
      }
      return false;
    } catch (e) {
      _ExceptionText = e.toString();
      return false;
    }
  }

  // Returns true if email address is in use.
  Future<bool> _checkIfEmailInUse(String emailAddress) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: '123456',
      );
      await credential.user?.delete();
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return true;
      } else {
        _ExceptionText = e.code;
        return false;
      }
    } catch (e) {
      _ExceptionText = e.toString();
      return false;
    }
  }

  @override
  void initState() {
    _SendSuccessful = false;
    _ExceptionText = null;
    _EmailAuthError = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double barRatio = 0.75;
    double buttonRatio = 0.6;
    double imageRatio = 0.6;
    double maxImageHeightRatio = 0.33;

    // TODO: implement forgot password page
    MaterialApp mainPage = MaterialApp(
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
          textTheme: GoogleFonts.robotoTextTheme()
      ),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.robotoTextTheme()
      ),
      home: SafeArea(
        child: Builder(
          builder: (context) => Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Quên mật khẩu', style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)
              ),
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.circleChevronLeft, size: 40,
                      color: Theme.of(context).colorScheme.primary)
              ),
            ),

            body: SingleChildScrollView(
              reverse: true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: max(640, MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // image
                    Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * imageRatio,
                        height: MediaQuery.of(context).size.width * imageRatio < MediaQuery.of(context).size.height * maxImageHeightRatio ?
                        MediaQuery.of(context).size.width * imageRatio : MediaQuery.of(context).size.height * maxImageHeightRatio,
                        child: Image.asset(
                            'assets/image/forgotpass_image.png')
                    ),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Hãy nhập email và chúng tôi sẽ gửi\n đường link đặt lại mật khẩu',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                    ),

                    Container( // forms
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground)
                              ),
                              Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * barRatio,
                                  child: Scaffold(
                                      resizeToAvoidBottomInset: false,
                                      backgroundColor: Colors.redAccent.withOpacity(0.0),
                                      body: TextField(
                                        controller: _EmailController,
                                        focusNode: _EmailFocus,
                                        onTap: () {
                                          _EmailAuthError = null;
                                        },
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: Theme.of(context).colorScheme.onBackground),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 3, color: Colors.black),
                                            borderRadius: BorderRadius.circular(50.0),
                                          ),

                                          helperText: " ",
                                          errorText: _EmailAuthError, // validator
                                        ),
                                      )
                                  )
                              )
                            ],
                          ),

                          // SizedBox(height: 5),
                        ],
                      ),
                    ),

                    Container( // Register button
                      alignment: Alignment.center,
                      height: 48,
                      margin: const EdgeInsets.only(bottom: 32.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  width: 4,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                        ),
                        onPressed: () async {
                          /* do something */
                          _ResetPasswordButton(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * buttonRatio,
                          alignment: Alignment.center,
                          child: Text("Gửi", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );

    // TODO: implement "sent email successfully" notification

    MaterialApp subPage = MaterialApp(
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
          textTheme: GoogleFonts.robotoTextTheme()
      ),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.robotoTextTheme()
      ),
      home: SafeArea(
        child: Builder(
          builder: (context) => Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Quên mật khẩu', style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)
              ),
            ),

            body: SingleChildScrollView(
              reverse: true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: max(640, MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // image
                    Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * imageRatio,
                        height: MediaQuery.of(context).size.width * imageRatio < MediaQuery.of(context).size.height * maxImageHeightRatio ?
                        MediaQuery.of(context).size.width * imageRatio : MediaQuery.of(context).size.height * maxImageHeightRatio,
                        child: Image.asset(
                            'assets/image/sendmail_image.png')
                    ),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Chúng tôi đã gửi email cho bạn.\nHãy kiểm tra hộp thư.',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                    ),

                    // BUTTON
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container( // Resent button
                            alignment: Alignment.center,
                            height: 48,
                            margin: const EdgeInsets.only(bottom: 32.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.background,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 4,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                              ),
                              onPressed: () {
                                /* do something */
                                setState(() {
                                  _SendSuccessful = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * buttonRatio,
                                alignment: Alignment.center,
                                child: Text("Gửi lại mail", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground)),
                              ),
                            ),
                          ),

                          Container( // Back to login button
                            alignment: Alignment.center,
                            height: 48,
                            margin: const EdgeInsets.only(bottom: 32.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        width: 4,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                              ),
                              onPressed: () async {
                                /* do something */
                                Navigator.of(context).pushAndRemoveUntil(_createRoute(), (route) => false);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * buttonRatio,
                                alignment: Alignment.center,
                                child: Text("Đăng nhập", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary)),
                              ),
                            ),
                          )
                        ]
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );

    // TODO: implement build
    return !_SendSuccessful ? mainPage : subPage;
  }

  // CHANGE PAGE ANIMATION
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}