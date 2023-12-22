import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});
  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  bool _changeSuccess = false;

  // OLD PASSWORD
  bool _OldPasswordVisible = false;
  final _OldPasswordController = TextEditingController();
  FocusNode _OldPasswordFocus = FocusNode();
  String? _OldPasswordValidateText;

  // PASSWORD
  bool _PasswordVisible = false;
  final _PasswordController = TextEditingController();
  bool _firstEnterPasswordField = false;
  FocusNode _PasswordFocus = FocusNode();
  bool _PasswordCorrect = false;
  String? _PasswordValidateText;

  // RE-PASSWORD
  bool _RePasswordVisible = false;
  final _RePasswordController = TextEditingController();
  bool _firstEnterRePasswordField = false;
  FocusNode _RePasswordFocus = FocusNode();
  bool _RePasswordCorrect = false;
  String? _RePasswordValidateText;

  String? _ExceptionText;

  // VALIDATING
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
      } else if (value == _OldPasswordController.value.text) {
        _PasswordCorrect = false;
        errorText = "Mật khẩu không được trùng với mật khẩu hiện tại";
      } else {
        _PasswordCorrect = true;
      }
    }
    return _PasswordFocus.hasFocus ? null : errorText;
  }

  String? _RePasswordValidating(String value) {
    String? errorText;
    if (!_firstEnterRePasswordField) {
      return null;
    } else {
      if (value.isEmpty) {
        _RePasswordCorrect = false;
        errorText = "Vui lòng nhập lại mật khẩu";
      } else if (value.toString() != _PasswordController.value.text) {
        _RePasswordCorrect = false;
        errorText = "Nhập lại mật khẩu không trùng khớp";
      } else {
        _RePasswordCorrect = true;
      }
    }
    return _RePasswordFocus.hasFocus ? null : errorText;
  }

  void _ChangePassButton(context) async {
    _OldPasswordFocus.unfocus();
    _PasswordFocus.unfocus();
    _RePasswordFocus.unfocus();
    _PasswordValidateText = _PasswordValidating(_PasswordController.value.text);
    _RePasswordValidateText =
        _RePasswordValidating(_RePasswordController.value.text);
    if (_PasswordCorrect && _RePasswordCorrect) {
      // do something
      bool? result = true;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });

      result = await _changePassword(
          _OldPasswordController.value.text, _PasswordController.value.text);
      if (result == true) {
        _changeSuccess = true;
      }
      if (result == false) {
        _OldPasswordValidateText = 'Mật khẩu hiện tại không đúng';
      } else if (_ExceptionText != null) {
        String? message;
        message = _ExceptionText;
        _ExceptionText = null;

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.toString())));
      }
      Navigator.of(context, rootNavigator: true).pop();
    }

    setState(() {
      _firstEnterPasswordField = true;
      _firstEnterRePasswordField = true;
    });
  }

  Future<bool?> _changePassword(password, newPassword) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      print(user?.email);
      final cred = EmailAuthProvider.credential(
          email: user?.email ?? '', password: password);
      await user?.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code.contains('INVALID_LOGIN_CREDENTIALS')) {
        return false;
      } else {
        _ExceptionText = e.message;
        return null;
      }
    } catch (e) {
      print(e.toString());
      _ExceptionText = e.toString();
      return null;
    }
  }

  @override
  void initState() {
    _OldPasswordVisible = false;
    _PasswordVisible = false;
    _RePasswordVisible = false;
    _firstEnterPasswordField = false;
    _firstEnterRePasswordField = false;
    _PasswordCorrect = false;
    _RePasswordCorrect = false;
    _changeSuccess = false;

    // focus listener
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

    _RePasswordFocus.addListener(() {
      if (_RePasswordFocus.hasFocus) {
        _firstEnterRePasswordField = true;
        _RePasswordValidateText = null;
      } else {
        _RePasswordValidateText =
            _RePasswordValidating(_RePasswordController.value.text);
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double barRatio = 0.75;
    double buttonRatio = 0.6;
    double imageRatio = 0.6;
    double maxImageHeightRatio = 0.33;

    // TODO: implement change password Widget
    var ChangePasswordPage = SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Đổi mật khẩu',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,
                    size: 40, color: Theme.of(context).colorScheme.primary)),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: max(
                  MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height * 2,
                  640),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // image
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * imageRatio,
                      height: MediaQuery.of(context).size.width * imageRatio <
                              MediaQuery.of(context).size.height *
                                  maxImageHeightRatio
                          ? MediaQuery.of(context).size.width * imageRatio
                          : MediaQuery.of(context).size.height *
                              maxImageHeightRatio,
                      child: Image.asset('assets/image/changepass_image.png')),

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
                            Text('Mật khẩu hiện tại',
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
                                      controller: _OldPasswordController,
                                      focusNode: _OldPasswordFocus,
                                      obscureText: !_OldPasswordVisible,
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
                                            EdgeInsets.fromLTRB(12, 8, 12, 0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),

                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _OldPasswordVisible =
                                                  !_OldPasswordVisible;
                                            });
                                          },
                                          child: Icon(_OldPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        helperText: " ",
                                        errorText:
                                            _OldPasswordValidateText, // validator
                                      ),
                                    )))
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mật khẩu mới',
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
                                            EdgeInsets.fromLTRB(12, 8, 12, 0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.black),
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

                        // SizedBox(height: 5),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nhập lại mật khẩu mới',
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
                                      controller: _RePasswordController,
                                      focusNode: _RePasswordFocus,
                                      obscureText: !_RePasswordVisible,
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
                                            EdgeInsets.fromLTRB(12, 8, 12, 0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),

                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _RePasswordVisible =
                                                  !_RePasswordVisible;
                                            });
                                          },
                                          child: Icon(_RePasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        helperText: " ",
                                        errorText:
                                            _RePasswordValidateText, // validator
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
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
                        _ChangePassButton(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * buttonRatio,
                        alignment: Alignment.center,
                        child: Text("Lưu",
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
          ),
        ),
      ),
    );

    var ChangePasswordSuccessPage = SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Đổi mật khẩu',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: max(
                  MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height * 2,
                  640),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // image
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * imageRatio,
                      height: MediaQuery.of(context).size.width * imageRatio <
                              MediaQuery.of(context).size.height *
                                  maxImageHeightRatio
                          ? MediaQuery.of(context).size.width * imageRatio
                          : MediaQuery.of(context).size.height *
                              maxImageHeightRatio,
                      child: Image.asset(
                          'assets/image/changepass_success_image.png')),

                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Bạn đã thay đổi mật khẩu thành công!',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                        textAlign: TextAlign.center,
                      )),

                  Container(
                    // Finish button
                    alignment: Alignment.center,
                    height: 48,
                    margin: const EdgeInsets.only(bottom: 32.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
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
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * buttonRatio,
                        alignment: Alignment.center,
                        child: Text("Quay lại",
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
          ),
        ),
      ),
    );

    // TODO: implement change password success Widget
    return _changeSuccess ? ChangePasswordSuccessPage : ChangePasswordPage;
  }
}
