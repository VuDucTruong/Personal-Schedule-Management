import 'package:flutter/material.dart';

import '../../../config/text_styles/app_text_style.dart';
import '../../../config/theme/app_theme.dart';
import 'number_dialog.dart';

class RecurrencingDay extends StatefulWidget {
  RecurrencingDay(this.recurrenceDayData, {super.key});
  Map<String, dynamic> recurrenceDayData;
  @override
  _RecurrencingDayState createState() {
    return _RecurrencingDayState();
  }
}

class _RecurrencingDayState extends State<RecurrencingDay> {
  @override
  void initState() {
    super.initState();
    widget.recurrenceDayData['dayNumber'] = dayNumber;
  }

  String dayOption = 'Chọn ngày kết thúc lặp lại';
  String dayNumber = '1';
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InkWell(
          onTap: () async {
            String oldDay = dayNumber;
            dayNumber = await showDialog(
                  context: context,
                  builder: (context) => NumberDialog(oldDay),
                ) ??
                oldDay;
            if (dayNumber.isEmpty) dayNumber = oldDay;
            widget.recurrenceDayData['dayNumber'] = dayNumber;
            setState(() {});
          },
          child: ListTile(
            title: Text('Lặp lại mỗi'),
            trailing: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: lightColorScheme.primaryContainer),
              child: Center(
                  child: Text(
                '${dayNumber} ngày',
                style: AppTextStyle.h3,
              )),
            ),
          ),
        ),
        CheckboxListTile(
          value: isSelected,
          onChanged: (value) async {
            DateTime now = DateTime.now();
            DateTime? date = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: now,
                lastDate: DateTime(now.year + 5));
            widget.recurrenceDayData['endDate'] = date;
            if (date != null) {
              setState(() {
                isSelected = true;
                dayOption =
                    'Chọn ngày kết thúc: ${date.day}/${date.month}/${date.year}';
              });
            }
          },
          title: Text(dayOption),
        )
      ],
    );
  }
}
