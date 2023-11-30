import 'package:flutter/material.dart';

import '../../../config/text_styles/app_text_style.dart';
import '../../../config/theme/app_theme.dart';

class RecurrencingYear extends StatefulWidget {
  RecurrencingYear(this.recurrenceYearData, {super.key});
  Map<String, dynamic> recurrenceYearData;
  @override
  _RecurrencingYearState createState() {
    return _RecurrencingYearState();
  }
}

class _RecurrencingYearState extends State<RecurrencingYear> {
  late DateTime startDate;
  @override
  void initState() {
    super.initState();
    startDate = widget.recurrenceYearData['startDate'];
  }

  String dayOption = 'Chọn ngày kết thúc lặp lại';
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ListTile(
          title: Text('Lặp lại vào'),
          trailing: Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: lightColorScheme.primaryContainer),
            child: Center(
                child: Text(
              '${startDate.day}/${startDate.month} hàng năm',
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
            widget.recurrenceYearData['endDate'] = date;
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
