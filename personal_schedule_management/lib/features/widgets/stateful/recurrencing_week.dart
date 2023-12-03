import 'package:flutter/material.dart';

import '../../../config/text_styles/app_text_style.dart';
import '../../../config/theme/app_theme.dart';
import 'number_dialog.dart';

class RecurrencingWeek extends StatefulWidget {
  RecurrencingWeek(this.recurrenceWeekData, {super.key});
  Map<String, dynamic> recurrenceWeekData;
  @override
  _RecurrencingWeekState createState() {
    return _RecurrencingWeekState();
  }
}

class _RecurrencingWeekState extends State<RecurrencingWeek> {
  Map<String, bool> dayOfWeek = {
    'T2': false,
    'T3': false,
    'T4': false,
    'T5': false,
    'T6': false,
    'T7': false,
    'CN': false
  };
  String dayOption = 'Chọn ngày kết thúc lặp lại';
  bool isSelected = false;
  String weekNumber = '1';
  late List<dynamic> tempList;
  @override
  void initState() {
    super.initState();
    String key = weekdayToDay(DateTime.now().weekday);
    dayOfWeek[key] = true;
    tempList = widget.recurrenceWeekData['weekDays'];
    tempList.add(key);
    widget.recurrenceWeekData['weekNumber'] = weekNumber;
  }

  String weekdayToDay(int weekday) {
    switch (weekday) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return 'T2';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(4),
          height: 30,
          child: Center(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...dayOfWeek.entries.map((e) => GestureDetector(
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(child: Text(e.key)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: e.value
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Colors.grey),
                    ),
                    onTap: () {
                      setState(() {
                        dayOfWeek[e.key] = !e.value;
                      });
                      if (!e.value) {
                        tempList.add(e.key);
                      } else {
                        tempList.remove(e.key);
                      }
                    }))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            String oldWeek = weekNumber;
            weekNumber = await showDialog(
                  context: context,
                  builder: (context) => NumberDialog(oldWeek),
                ) ??
                oldWeek;
            if (weekNumber.isEmpty) weekNumber = oldWeek;
            widget.recurrenceWeekData['weekNumber'] = weekNumber;
            setState(() {});
          },
          child: ListTile(
            title: Text('Lặp lại mỗi'),
            trailing: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Center(
                  child: Text(
                '${weekNumber} tuần',
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
            widget.recurrenceWeekData['endDate'] = date;
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
