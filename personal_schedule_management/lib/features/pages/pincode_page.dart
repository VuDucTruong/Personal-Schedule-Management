import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

Future<UserCredential?> registerWithEmailAndPassword(
    String email, String password, String displayName) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user!.updateDisplayName(displayName);

    return userCredential;
  } catch (e) {
    print('Error creating user: $e');
    return null;
  }
}

class PincodePage extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  PincodePage(this.email, this.password, this.name);

  @override
  _PincodePageState createState() => _PincodePageState();
}

class _PincodePageState extends State<PincodePage> {
  double barRatio = 0.75;
  double buttonRatio = 0.3;
  double imageRatio = 0.6;
  double maxImageHeightRatio = 0.33;
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  String pinCode = '';

  String generateRandomCode() {
    Random random = Random();
    String code = '';
    for (int i = 0; i < 6; i++) {
      code += random.nextInt(10).toString();
    }
    return code;
  }

  void sendConfirmationCode(String code) async {
    String username = "personalschedulemanager@gmail.com";
    String password = "myocgxvnvsdybuhr";

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add('${widget.email}')
      ..subject = 'Confirmation Code'
      ..text = 'Your confirmation code is: $code';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error: $e');
    }
  }

  void resendConfirmationCode() {
    pinCode = generateRandomCode();
    sendConfirmationCode(pinCode);
  }

  @override
  void initState() {
    super.initState();
    pinCode = generateRandomCode();
    sendConfirmationCode(pinCode);
  }

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
            // appBar: AppBar(
            //   leading: IconButton(
            //       onPressed: () {},
            //       icon: Icon(FontAwesomeIcons.circleChevronLeft, size: 40,
            //           color: Theme.of(context).colorScheme.primary)
            //   ),
            // ),

            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // back button & image
                  Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(FontAwesomeIcons.circleChevronLeft,
                                  size: 40,
                                  color:
                                      Theme.of(context).colorScheme.primary)),

                          // logo
                          Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width *
                                  imageRatio,
                              height: MediaQuery.of(context).size.width *
                                          imageRatio <
                                      MediaQuery.of(context).size.height *
                                          maxImageHeightRatio
                                  ? MediaQuery.of(context).size.width *
                                      imageRatio
                                  : MediaQuery.of(context).size.height *
                                      maxImageHeightRatio,
                              child: Image.asset(
                                  'assets/image/pincode_image.png')),

                          SizedBox(width: 40)
                        ],
                      )),

                  // Title
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Text('Xác nhận tài khoản của bạn',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.surfaceTint,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold))),

                  // help text
                  Container(
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Text('Nhập mã xác nhận đã được gửi đến:',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground))),
                        Container(
                            alignment: Alignment.center,
                            child: Text('<${widget.email}>',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),

                  // input code

                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 6) {
                              return ""; // nothing to show
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor:
                                hasError ? Colors.green : Colors.white,
                            selectedColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                            selectedFillColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            inactiveColor: Theme.of(context).colorScheme.error,
                            inactiveFillColor:
                                Theme.of(context).colorScheme.errorContainer,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: TextStyle(fontSize: 20, height: 1.6),
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                          onChanged: (value) {
                            // print(value);
                            // setState(() {
                            //   currentText = value;
                            // });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  // Confirm button
                  Container(
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
                        if (currentText == pinCode) {
                          UserCredential? userCredential =
                              await registerWithEmailAndPassword(
                                  widget.email, widget.password, widget.name);
                          if (userCredential != null) {
                            String userId = userCredential.user!.uid;

                            print('Account created successfully!');
                          } else {
                            print('Account creation failed!');
                          }
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thông báo'),
                                content: Text(
                                  'XÁC NHẬN THÀNH CÔNG',
                                  style: AppTextStyle.h1,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thông báo'),
                                content: Text(
                                  'MÃ XÁC NHẬN KHÔNG CHÍNH XÁC!!!',
                                  style: AppTextStyle.h1,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * buttonRatio,
                        alignment: Alignment.center,
                        child: Text("Xác nhận",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)),
                      ),
                    ),
                  ),

                  // Resend text
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: Text('Chưa nhận được mã xác nhận?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground))),
                        Container(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  resendConfirmationCode();
                                },
                                child: Text('Gửi lại mã',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            decoration:
                                                TextDecoration.underline))))
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
