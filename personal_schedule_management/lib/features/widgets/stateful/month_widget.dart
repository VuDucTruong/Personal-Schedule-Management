import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';

class MonthWidget extends StatefulWidget {
  MonthWidget({super.key});

  DateTime monthOfYear = DateTime.now();

  @override
  _MonthWidgetState createState() {
    return _MonthWidgetState();
  }
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.circleArrowLeft,
              color: lightColorScheme.primaryContainer,
            ),
            onTap: () {
              setState(() {
                widget.monthOfYear = DateTime(
                    widget.monthOfYear.year, widget.monthOfYear.month - 1);
              });
            },
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Tháng ${widget.monthOfYear.month} ${widget.monthOfYear.year}',
            style: AppTextStyle.h2,
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.circleArrowRight,
              color: lightColorScheme.primaryContainer,
            ),
            onTap: () {
              setState(() {
                widget.monthOfYear = DateTime(
                    widget.monthOfYear.year, widget.monthOfYear.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }
}
