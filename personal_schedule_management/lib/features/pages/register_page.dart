import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:email_validator/email_validator.dart';

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

  // email field
  bool _firstEnterEmailField = false;
  final _EmailController = TextEditingController();
  FocusNode _EmailFocus = FocusNode();
  bool _EmailCorrect = false;
  String? _EmailAuthError;

  // password field
  bool _PasswordVisible = false;
  final _PasswordController = TextEditingController();
  bool _firstEnterPasswordField = false;
  FocusNode _PasswordFocus = FocusNode();
  bool _PasswordCorrect = false;
  String? _PasswordAuthError;

  String? _ExceptionText;

  // VALIDATING
  String? _NameValidating (String value) {
    String? errorText;
    if (!_firstEnterNameField) {
        return null;
    }
    else
    {
      if (value.isEmpty) {
        _NameCorrect = false;
        errorText = "Vui lòng nhập Họ & tên";
      }
      else
      {
        _NameCorrect = true;
      }
    }
    return _NameFocus.hasFocus ? null : errorText;
  }

  String? _EmailValidating (String value) {
    String? errorText;
    if (!_firstEnterEmailField) {
      return null;
    }
    else
    {
      if (value.isEmpty) {
        _EmailCorrect = false;
        errorText = "Vui lòng nhập Email";
      }
      else if (!EmailValidator.validate(value)) {
        _EmailCorrect = false;
        errorText = "Email không hợp lệ";
      }
      else if (_EmailAuthError != null) {
        errorText = _EmailAuthError;
        return errorText;
      }
      else
      {
        _EmailCorrect = true;
      }
    }
    return _EmailFocus.hasFocus ? null : errorText;
  }

  String? _PasswordValidating (String value) {
    String? errorText;
    if (!_firstEnterPasswordField){
      return null;
    }
    else
    {
      if (value.isEmpty) {
        _PasswordCorrect = false;
        errorText = "Vui lòng nhập mật khẩu";
      }
      else if (value.length < 8) {
        _PasswordCorrect = false;
        errorText = "Mật khẩu phải từ 8 kí tự trở lên";
      }
      else if (_PasswordAuthError != null) {
        errorText = _PasswordAuthError;
        return errorText;
      }
      else
      {
        _PasswordCorrect = true;
      }
    }
    return _PasswordFocus.hasFocus ? null : errorText;
  }

  // SIGN UP

  void _RegisterButton (context) async {

    if (_NameCorrect && _EmailCorrect && _PasswordCorrect)
    {
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

      await _signup(_EmailController.text, _PasswordController.text, result);
      if (result == true)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tạo tài khoản thành công'))
        );
      }
      else
      {
        String? message = 'Tạo tài khoản thất bại';
        if (_ExceptionText != null) {
          message = _ExceptionText;
          _ExceptionText = null;
        }

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.toString()))
        );
      }
      Navigator.of(context).pop();
    }

    setState(() {
      _firstEnterNameField = true;
      _firstEnterEmailField = true;
      _firstEnterPasswordField = true;
    });
  }

  Future<void> _signup(emailAddress, password, result) async {
    try {
      result = true;
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _PasswordAuthError = 'Mật khẩu quá yếu';
      } else if (e.code == 'email-already-in-use') {
        _EmailAuthError = 'Email đã được sử dụng';
      }
      result = false;
    } catch (e) {
      // do nothing
      _ExceptionText = e.toString();
      result = false;
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
    _PasswordAuthError = null;
    _EmailAuthError = null;
    super.initState();
  }

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
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container( // Logo & name
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 72,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  child: CircleAvatar(
                                    radius: 66,
                                    backgroundImage: AssetImage(
                                        'assets/image/logo.png'),
                                  ),
                                )
                            ),

                            Container(
                                alignment: Alignment.center,
                                child: Text('Chào mừng đến với', style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground)
                                )
                            ),

                            Container(
                                alignment: Alignment.center,
                                child: Text('Magic Calendar', style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.surfaceTint)
                                )
                            )

                          ],
                        ),
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
                                Text('Họ và tên', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground)
                                ),
                                Container(
                                    height: 70,
                                    width:  MediaQuery.of(context).size.width * barRatio,
                                    child: Scaffold(
                                        resizeToAvoidBottomInset: false,
                                        backgroundColor: Colors.redAccent.withOpacity(0.0),
                                        body: TextField(
                                          controller: _NameController,
                                          focusNode: _NameFocus,
                                          onTap: () {
                                            _firstEnterNameField = true;
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
                                            errorText: _NameValidating(_NameController.value.text), // validator
                                          ),
                                        )
                                    )
                                )
                              ],
                            ),

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
                                            _firstEnterEmailField = true;
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
                                            errorText: _EmailValidating(_EmailController.value.text), // validator
                                          ),
                                        )
                                    )
                                )
                              ],
                            ),


                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mật khẩu', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground)
                                ),
                                Container(
                                    height: 70,
                                    width:  MediaQuery.of(context).size.width * barRatio,
                                    child: Scaffold(
                                        resizeToAvoidBottomInset: false,
                                        backgroundColor: Colors.redAccent.withOpacity(0.0),
                                        body: TextField(
                                          controller: _PasswordController,
                                          focusNode: _PasswordFocus,
                                          obscureText: !_PasswordVisible,
                                          onTap: () {
                                            _PasswordAuthError = null;
                                            _firstEnterPasswordField = true;
                                          },
                                          obscuringCharacter: '*',
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

                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _PasswordVisible = !_PasswordVisible;
                                                });
                                              },
                                              child: Icon(
                                                  _PasswordVisible ? Icons.visibility : Icons.visibility_off),
                                            ),
                                            helperText: " ",
                                            errorText: _PasswordValidating(_PasswordController.value.text), // validator
                                          ),

                                        )
                                    )
                                )
                              ],
                            ),
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
                            _RegisterButton(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * buttonRatio,
                            alignment: Alignment.center,
                            child: Text("Đăng kí", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary)),
                          ),
                        ),
                      )
                    ],
                  ),
              ),
            )
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}


