import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class ChangePassPage extends StatelessWidget {
  const ChangePassPage({super.key});

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
            resizeToAvoidBottomInset: false,
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

            body: Column(
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
                              height: 40,
                              width: MediaQuery.of(context).size.width * barRatio,
                              child: Scaffold(
                                  resizeToAvoidBottomInset: false,
                                  backgroundColor: Colors.redAccent.withOpacity(0.0),
                                  body: TextField(
                                    obscureText: true,
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
                                    ),
                                  )
                              )
                          )
                        ],
                      ),

                      SizedBox(height: 20),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nhập lại mật khẩu mới', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground)
                          ),
                          Container(
                              height: 40,
                              width:  MediaQuery.of(context).size.width * barRatio,
                              child: Scaffold(
                                  resizeToAvoidBottomInset: false,
                                  backgroundColor: Colors.redAccent.withOpacity(0.0),
                                  body: TextField(
                                    obscureText: true,
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

      debugShowCheckedModeBanner: false,
    );
  }
}