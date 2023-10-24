import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class PincodePage extends StatelessWidget {
  const PincodePage({super.key});

  @override
  Widget build(BuildContext context) {
    double barRatio = 0.75;
    double buttonRatio = 0.3;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              // Title
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 16.0),
                child: Text('Xác nhận tài khoản của bạn',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)
                )
              ),


                // help text
                Container(
                  child: Column(

                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: Text('Nhập mã xác nhận đã được gửi đến:', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground)
                          )
                      ),

                      Container(
                          alignment: Alignment.center,
                          child: Text('<example@gmail.com>', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold)
                          )
                      )

                    ],
                  ),
                ),

                // input code
                Container(
                  height: 48,
                  width:  MediaQuery.of(context).size.width * barRatio,
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.redAccent.withOpacity(0.0),
                      body: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.black),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      )
                  )
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
                      child: Text("Xác nhận", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)),
                    ),
                  ),
                ),

                // Resend text
                Container(
                  child: Column(

                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: Text('Chưa nhận được email?', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground)
                          )
                      ),

                      Container(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {},
                              child: Text('Gửi lại mã', style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 22,
                                    decoration: TextDecoration.underline)
                              )
                          )
                      )

                    ],
                  ),
                ),
                SizedBox(height: 10)

              ],
            ),
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}