import 'package:flutter/material.dart';

import '../../../config/text_styles/app_text_style.dart';
import '../../../config/theme/app_theme.dart';

class RecurrencingMonth extends StatefulWidget {
  RecurrencingMonth(this.recurrenceMonthData, {super.key});
  Map<String, dynamic> recurrenceMonthData;
  @override
  _RecurrencingMonthState createState() {
    return _RecurrencingMonthState();
  }
}

class _RecurrencingMonthState extends State<RecurrencingMonth> {
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.recurrenceMonthData['startDate'];
  }

  String dayOption = 'Chọn ngày kết thúc lặp lại';
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ListTile(
          title: Text('Lặp lại hàng tháng vào '),
          trailing: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Center(
                child: Text(
              'ngày ${startDate.day}',
              style: AppTextStyle.h3,
            )),
          ),
        ),
        CheckboxListTile(
          value: isSelected,
          onChanged: (value) async {
            DateTime? date = await showDatePicker(
                context: context,
                initialDate: startDate,
                firstDate: startDate,
                lastDate: DateTime(startDate.year + 5));
            widget.recurrenceMonthData['endDate'] = date;
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
