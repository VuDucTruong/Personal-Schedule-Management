import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class workslist extends StatefulWidget {
  const workslist({super.key});

  @override
  State<workslist> createState() => _workslistState();
}

class _workslistState extends State<workslist> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          width: double.infinity,
          child: InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {},
            splashColor: Theme.of(context).colorScheme.primaryContainer,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(FontAwesomeIcons.arrowLeft),
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text('WORKS LIST \t\t\t\t\t',
              style: AppTextStyle.h2.copyWith(
                letterSpacing: 1.175,
              )),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Day ...',
              style: AppTextStyle.h2.copyWith(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 45),
            Row(
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: (size.width - 68) / 3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ALL',
                      style: AppTextStyle.h3,
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: (size.width - 68) / 3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'DAILY',
                      style: AppTextStyle.h3,
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: (size.width - 68) / 3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'NOTICED',
                      style: AppTextStyle.h3,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
