import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/features/pages/auth%20pages/pincode_page.dart';

import '../../../config/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // name field
  bool _firstEnterNameField = false;
  final _NameController = TextEditingController();
  FocusNode _NameFocus = FocusNode();
  bool _NameCorrect = false;
  String? _NameValidateText;

  // email field
  bool _firstEnterEmailField = false;
  final _EmailController = TextEditingController();
  FocusNode _EmailFocus = FocusNode();
  bool _EmailCorrect = false;
  String? _EmailValidateText;

  // password field
  bool _PasswordVisible = false;
  final _PasswordController = TextEditingController();
  bool _firstEnterPasswordField = false;
  FocusNode _PasswordFocus = FocusNode();
  bool _PasswordCorrect = false;
  String? _PasswordValidateText;

  String? _ExceptionText;

  // VALIDATING
  String? _NameValidating(String value) {
    String? errorText;
    if (!_firstEnterNameField) {
      return null;
    } else {
      if (value.isEmpty) {
        _NameCorrect = false;
        errorText = "Vui lòng nhập Họ & tên";
      } else {
        _NameCorrect = true;
      }
    }
    return _NameFocus.hasFocus ? null : errorText;
  }

  String? _EmailValidating(String value) {
    String? errorText;
    if (!_firstEnterEmailField) {
      return null;
    } else {
      if (value.isEmpty) {
        _EmailCorrect = false;
        errorText = "Vui lòng nhập Email";
      } else if (!EmailValidator.validate(value)) {
        _EmailCorrect = false;
        errorText = "Email không hợp lệ";
      } else {
        _EmailCorrect = true;
      }
    }
    return _EmailFocus.hasFocus ? null : errorText;
  }

  String? _PasswordValidating(String value) {
    String? errorText;
    if (!_firstEnterPasswordField) {
      return null;
    } else {
      if (value.isEmpty) {
        _PasswordCorrect = false;
        errorText = "Vui lòng nhập mật khẩu";
      } else if (value.length < 8) {
        _PasswordCorrect = false;
        errorText = "Mật khẩu phải từ 8 kí tự trở lên";
      } else {
        _PasswordCorrect = true;
      }
    }
    return _PasswordFocus.hasFocus ? null : errorText;
  }

  // SIGN UP

  void _RegisterButton(context) async {
    _NameFocus.unfocus();
    _EmailFocus.unfocus();
    _PasswordFocus.unfocus();
    setState(() {
      _NameValidateText = _NameValidating(_NameController.value.text);
      _EmailValidateText = _EmailValidating(_EmailController.value.text);
      _PasswordValidateText =
          _PasswordValidating(_PasswordController.value.text);
    });
    if (_NameCorrect && _EmailCorrect && _PasswordCorrect) {
      // do something
      bool? result;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });

      result = await _checkIfEmailInUse(_EmailController.value.text);
      Navigator.of(context).pop();
      if (result == true) {
        _EmailValidateText = 'Email đã được sử dụng';
      }
      if (result == false) {
        // Chuyển hướng sang PINCODE page để xác thực tài khoản
        Navigator.of(context, rootNavigator: true)
            .pushAndRemoveUntil(_createRoute(), (route) => false);
      } else if (_ExceptionText != null) {
        String? message = _ExceptionText;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.toString())));
      }
    }

    setState(() {
      _firstEnterNameField = true;
      _firstEnterEmailField = true;
      _firstEnterPasswordField = true;
    });
  }

  Future<bool?> _checkIfEmailInUse(String emailAddress) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
        return null;
      }
    } catch (e) {
      _ExceptionText = e.toString();
      return null;
    }
  }

  @override
  void initState() {
    _PasswordVisible = false;
    _firstEnterNameField = false;
    _firstEnterEmailField = false;
    _firstEnterPasswordField = false;
    _NameCorrect = false;
    _EmailCorrect = false;
    _PasswordCorrect = false;

    // add listener
    _NameFocus.addListener(() {
      if (_NameFocus.hasFocus) {
        _firstEnterNameField = true;
        _NameValidateText = null;
      } else {
        _NameValidateText = _NameValidating(_NameController.value.text);
        setState(() {});
      }
    });

    _EmailFocus.addListener(() {
      if (_EmailFocus.hasFocus) {
        _EmailValidateText = null;
        _firstEnterEmailField = true;
      } else {
        _EmailValidateText = _EmailValidating(_EmailController.value.text);
        setState(() {});
      }
    });

    _PasswordFocus.addListener(() {
      if (_PasswordFocus.hasFocus) {
        _firstEnterPasswordField = true;
        _PasswordValidateText = null;
      } else {
        _PasswordValidateText =
            _PasswordValidating(_PasswordController.value.text);
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double barRatio = 0.75;
    double buttonRatio = 0.6;

    // TODO: implement build
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
        theme: AppTheme.of(context, listen: true).lightTheme,
        darkTheme: AppTheme.of(context, listen: true).darkTheme,
        themeMode: AppTheme.of(context, listen: true).darkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        home: SafeArea(
          child: Builder(
            builder: (context) => Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: Icon(Icons.arrow_back,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                body: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: max(
                        640,
                        MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // Logo & name
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 72,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    child: CircleAvatar(
                                      radius: 66,
                                      backgroundImage:
                                          AssetImage('assets/image/logo.jpg'),
                                    ),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text('Chào mừng đến với',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground))),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text('Magic Calendar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceTint)))
                            ],
                          ),
                        ),
                        Container(
                          // forms
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Họ và tên',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground)),
                                  Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          barRatio,
                                      child: Scaffold(
                                          resizeToAvoidBottomInset: false,
                                          backgroundColor:
                                              Colors.redAccent.withOpacity(0.0),
                                          body: TextField(
                                            controller: _NameController,
                                            focusNode: _NameFocus,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      12, 8, 12, 0),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              helperText: " ",
                                              errorText:
                                                  _NameValidateText, // validator
                                            ),
                                          )))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground)),
                                  Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          barRatio,
                                      child: Scaffold(
                                          resizeToAvoidBottomInset: false,
                                          backgroundColor:
                                              Colors.redAccent.withOpacity(0.0),
                                          body: TextField(
                                            controller: _EmailController,
                                            focusNode: _EmailFocus,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      12, 8, 12, 0),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              helperText: " ",
                                              errorText:
                                                  _EmailValidateText, // validator
                                            ),
                                          )))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mật khẩu',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground)),
                                  Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          barRatio,
                                      child: Scaffold(
                                          resizeToAvoidBottomInset: false,
                                          backgroundColor:
                                              Colors.redAccent.withOpacity(0.0),
                                          body: TextField(
                                            controller: _PasswordController,
                                            focusNode: _PasswordFocus,
                                            obscureText: !_PasswordVisible,
                                            obscuringCharacter: '*',
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      12, 8, 12, 0),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),

                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _PasswordVisible =
                                                        !_PasswordVisible;
                                                  });
                                                },
                                                child: Icon(_PasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                              ),
                                              helperText: " ",
                                              errorText:
                                                  _PasswordValidateText, // validator
                                            ),
                                          )))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // Register button
                          alignment: Alignment.center,
                          height: 48,
                          margin: const EdgeInsets.only(bottom: 32.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      width: 4,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                            onPressed: () async {
                              /* do something */
                              _RegisterButton(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width *
                                  buttonRatio,
                              alignment: Alignment.center,
                              child: Text("Đăng kí",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PincodePage(
          _EmailController.value.text,
          _PasswordController.value.text,
          _NameController.value.text),
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
