import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double barRatio = 0.75;

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
          textTheme: GoogleFonts.robotoTextTheme()),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.robotoTextTheme()),
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container( // back button
                  width: 50,
                  margin: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.circleChevronLeft, size: 40,
                          color: Colors.deepPurple)
                  )
              ),

              Container( // Logo & name
                child: Column(

                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: const CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.deepPurple,
                          child: CircleAvatar(
                            radius: 66,
                            backgroundImage: AssetImage(
                                'assets/image/logo.png'),
                          ),
                        )
                    ),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Wellcome to', style: Theme.of(context).textTheme.headlineSmall)
                    ),

                    Container(
                        alignment: Alignment.center,
                        child: Text('Personal Scheduler', style: Theme.of(context).textTheme.headlineMedium)
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
                        Text('Tên tài khoản', style: Theme.of(context).textTheme.bodyMedium),
                        Container(
                            height: 40,
                            width:  MediaQuery.of(context).size.width * barRatio,
                            child: Scaffold(
                                resizeToAvoidBottomInset: false,
                                backgroundColor: Colors.redAccent.withOpacity(0.0),
                                body: TextField(
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3, color: Colors.black),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                )
                            )
                        )
                      ],
                    ),

                    SizedBox(height: 10),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mật khẩu', style: Theme.of(context).textTheme.bodyMedium),
                        Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * barRatio,
                            child: Scaffold(
                                resizeToAvoidBottomInset: false,
                                backgroundColor: Colors.redAccent.withOpacity(0.0),
                                body: TextField(
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3, color: Colors.black),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                )
                            )
                        )
                      ],
                    ),

                    SizedBox(height: 10),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: Theme.of(context).textTheme.bodyMedium),
                        Container(
                            height: 40,
                            width:  MediaQuery.of(context).size.width * barRatio,
                            child: Scaffold(
                                resizeToAvoidBottomInset: false,
                                backgroundColor: Colors.redAccent.withOpacity(0.0),
                                body: TextField(
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3, color: Colors.black),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
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
                margin: const EdgeInsets.only(bottom: 32.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.deepPurple,
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
                    width: MediaQuery.of(context).size.width * barRatio,
                    height: 48,
                    alignment: Alignment.center,
                    child: const Text("Đăng kí", style: AppTextStyle.h2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}