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

  // email field
  bool _firstEnterEmailField = false;
  final _EmailController = TextEditingController();
  FocusNode _EmailFocus = FocusNode();

  // password field
  bool _passwordVisible = false;
  final _passwordController = TextEditingController();
  bool _firstEnterPasswordField = false;
  FocusNode _PasswordFocus = FocusNode();

  // VALIDATING
  String? _NameValidating (String value) {
    if (!_firstEnterNameField) {
        return null;
    }
    else if (!_NameFocus.hasFocus)
    {
      if (value.isEmpty) {
        return "Vui lòng nhập Họ & tên";
      }
    }

  }

  String? _EmailValidating (String value) {
    if (!_firstEnterEmailField) {
      return null;
    }
    else if (!_EmailFocus.hasFocus)
    {
      if (value.isEmpty) {
        return "Vui lòng nhập Email";
      }
      else if (!EmailValidator.validate(value)) {
        return "Email không hợp lệ";
      }
    }
  }

  String? _PasswordValidating (String value) {
    if (!_firstEnterPasswordField){
      return null;
    }
    else if (!_PasswordFocus.hasFocus) {
      if (value.isEmpty) {
        return "Vui lòng nhập mật khẩu";
      }
      else if (value.length < 8) {
        return "Mật khẩu phải từ 8 kí tự trở lên";
      }
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
    _firstEnterNameField = false;
    _firstEnterEmailField = false;
    _firstEnterPasswordField = false;
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.circleChevronLeft, size: 40,
                color: Theme.of(context).colorScheme.primary)
              ),
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container( // Logo & name
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

                      // SizedBox(height: 5),

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

                      // SizedBox(height: 10),

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
                                    controller: _passwordController,
                                    focusNode: _PasswordFocus,
                                    obscureText: !_passwordVisible,
                                    onTap: () {
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
                                        onLongPress: () {
                                          setState(() {
                                            _passwordVisible = true;
                                          });
                                        },
                                        onLongPressUp: () {
                                          setState(() {
                                            _passwordVisible = false;
                                          });
                                        },
                                        child: Icon(
                                            _passwordVisible ? Icons.visibility : Icons.visibility_off),
                                      ),
                                      helperText: " ",
                                      errorText: _PasswordValidating(_passwordController.value.text), // validator
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
                    onPressed: () {
                      /* do something */
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
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}


