import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});
  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  String? _emailAddress;

  // PASSWORD
  bool _PasswordVisible = false;
  final _PasswordController = TextEditingController();
  bool _firstEnterPasswordField = false;
  FocusNode _PasswordFocus = FocusNode();
  bool _PasswordCorrect = false;

  // RE-PASSWORD
  bool _RePasswordVisible = false;
  final _RePasswordController = TextEditingController();
  bool _firstEnterRePasswordField = false;
  FocusNode _RePasswordFocus = FocusNode();
  bool _RePasswordCorrect = false;

  String? _ExceptionText;

  // VALIDATING
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
      // else if (_PasswordAuthError != null) {
      //   errorText = _PasswordAuthError;
      //   return errorText;
      // }
      else
      {
        _PasswordCorrect = true;
      }
    }
    return _PasswordFocus.hasFocus ? null : errorText;
  }

  String? _RePasswordValidating (String value) {
    String? errorText;
    if (!_firstEnterRePasswordField){
      return null;
    }
    else
    {
      if (value.isEmpty) {
        _RePasswordCorrect = false;
        errorText = "Vui lòng nhập lại mật khẩu";
      }
      else if (value.toString() != _PasswordController.value.text) {
        _RePasswordCorrect = false;
        errorText = "Nhập lại mật khẩu không trùng khớp";
      }
      // else if (_RePasswordAuthError != null) {
      //   errorText = _RePasswordAuthError;
      //   return errorText;
      // }
      else
      {
        _RePasswordCorrect = true;
      }
    }
    return _RePasswordFocus.hasFocus ? null : errorText;
  }

  void _ChangePassButton (context) async {
    _PasswordFocus.unfocus();
    _RePasswordFocus.unfocus();
    if (_PasswordCorrect && _RePasswordCorrect)
    {
      // do something
      bool? result = true;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
      );

      await _resetPassword(_emailAddress, _PasswordController.value.text, result);
      if (result == true)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tạo mật khẩu mới thành công'))
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
      _firstEnterPasswordField = true;
      _firstEnterRePasswordField = true;
    });
  }

  Future<void> _resetPassword(emailAddress, password, result) async {
    try {
      result = true;
      // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: emailAddress,
      //   password: password,
      // );

    } on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   _PasswordAuthError = 'Mật khẩu quá yếu';
      // } else if (e.code == 'email-already-in-use') {
      //   _EmailAuthError = 'Email đã được sử dụng';
      // }
      result = false;
    } catch (e) {
      _ExceptionText = e.toString();
      result = false;
    }
  }

  @override
  void initState() {
    _PasswordVisible = false;
    _RePasswordVisible = false;
    _firstEnterPasswordField = false;
    _firstEnterRePasswordField = false;
    _PasswordCorrect = false;
    _RePasswordCorrect = false;
    // _PasswordAuthError = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double barRatio = 0.75;
    double buttonRatio = 0.6;
    double imageRatio = 0.6;
    double maxImageHeightRatio = 0.33;

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
              centerTitle: true,
              title: Text('Tạo mật khẩu mới', style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2,
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
                            'assets/image/changepass_image.png')
                    ),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Hãy nhập mật khẩu mới', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold)
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
                              Text('Mật khẩu mới', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground)
                              ),
                              Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * barRatio,
                                  child: Scaffold(
                                      resizeToAvoidBottomInset: false,
                                      backgroundColor: Colors.redAccent.withOpacity(0.0),
                                      body: TextField(
                                        controller: _PasswordController,
                                        focusNode: _PasswordFocus,
                                        obscureText: !_PasswordVisible,
                                        onTap: () {
                                          // _PasswordAuthError = null;
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

                          // SizedBox(height: 5),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nhập lại mật khẩu mới', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground)
                              ),
                              Container(
                                  height: 70,
                                  width:  MediaQuery.of(context).size.width * barRatio,
                                  child: Scaffold(
                                      resizeToAvoidBottomInset: false,
                                      backgroundColor: Colors.redAccent.withOpacity(0.0),
                                      body: TextField(
                                        controller: _RePasswordController,
                                        focusNode: _RePasswordFocus,
                                        obscureText: !_RePasswordVisible,
                                        onTap: () {
                                          // _PasswordAuthError = null;
                                          _firstEnterRePasswordField = true;
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
                                                _RePasswordVisible = !_RePasswordVisible;
                                              });
                                            },
                                            child: Icon(
                                                _RePasswordVisible ? Icons.visibility : Icons.visibility_off),
                                          ),
                                          helperText: " ",
                                          errorText: _RePasswordValidating(_RePasswordController.value.text), // validator
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
                          _ChangePassButton(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * buttonRatio,
                          alignment: Alignment.center,
                          child: Text("Lưu", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
  }
}