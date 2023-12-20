import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../config/theme/app_theme.dart';
import '../../../main.dart';

class NoInternetWidget extends StatelessWidget {
  NoInternetWidget({super.key});

  Future<void> ReloadButton(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    if (await InternetConnectionChecker().hasConnection) {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          _createRoute(), (route) => false);
    }
    else
    {
      print("still no connection");
        Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    const imageRatio = 0.6;
    const maxImageHeightRatio = 0.3;
    const buttonRatio = 0.7;
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
    home: Builder(
      builder: (context) =>
        PopScope(
          canPop: false,
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      width:
                      MediaQuery.of(context).size.width * imageRatio,
                      height: MediaQuery.of(context).size.width *
                          imageRatio <
                          MediaQuery.of(context).size.height *
                              maxImageHeightRatio
                          ? MediaQuery.of(context).size.width * imageRatio
                          : MediaQuery.of(context).size.height *
                          maxImageHeightRatio,
                      child:
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.error,
                              BlendMode.srcIn),
                          child: const Image(
                            image: AssetImage(
                                'assets/image/no_internet.png'),
                          ),
                        ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Không có kết nối Internet!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(height: 20),
                  // BUTTON
                  Container(
                    // Reload button
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
                        ReloadButton(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            buttonRatio,
                        alignment: Alignment.center,
                        child: Text("Tải lại",
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
          )
        )
      )
    );
  }

  // CHANGE PAGE ANIMATION
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      const MyApp(),
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