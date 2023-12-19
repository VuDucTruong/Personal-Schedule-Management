import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/widgets/stateful/recurrencing_day.dart';
import 'package:personal_schedule_management/features/widgets/stateful/recurrencing_month.dart';
import 'package:personal_schedule_management/features/widgets/stateful/recurrencing_week.dart';
import 'package:personal_schedule_management/features/widgets/stateful/recurrencing_year.dart';

class CreateRecurrenceDialog extends StatefulWidget {
  CreateRecurrenceDialog(this.startDate, {super.key});
  DateTime? startDate;
  @override
  State<CreateRecurrenceDialog> createState() => CreateRecurrenceDialogState();
}

class CreateRecurrenceDialogState extends State<CreateRecurrenceDialog>
    with TickerProviderStateMixin {
  final List<String> recurrenceTypeList = [
    'Hàng ngày',
    'Hàng tuần',
    'Hàng tháng',
    'Hàng năm'
  ];
  late TabController tabController;
  bool isSelected = false;
  String dayNumber = '1', weekNumber = '1';
  Map<String, dynamic> recurrenceDayData = {
    'dayNumber': null,
    'endDate': null
  }; // dayNumber - endDate
  Map<String, dynamic> recurrenceWeekData = {
    'weekDays': [],
    'weekNumber': null,
    'endDate': null
  }; // weekDays - weekNumber - endDate
  Map<String, dynamic> recurrenceMonthData = {
    'startDate': null,
    'endDate': null
  }; // enable - endDate
  Map<String, dynamic> recurrenceYearData = {
    'startDate': null,
    'endDate': null
  }; // enable - endDate
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    recurrenceMonthData['startDate'] = widget.startDate;
    recurrenceYearData['startDate'] = widget.startDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Đặt lặp lại', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      content: Builder(builder: (context) {
        return SizedBox(
          width: 800,
          height: 250,
          child: Column(children: [
            TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: [
                ...recurrenceTypeList.map((e) => Container(
                      height: 30,
                      child: Text(e),
                    ))
              ],
              onTap: (value) {
                selectedTab = value;
                tabController.animateTo(value);
              },
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: Card(
              color: Theme.of(context).colorScheme.background,
              child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    RecurrencingDay(recurrenceDayData),
                    RecurrencingWeek(recurrenceWeekData),
                    RecurrencingMonth(recurrenceMonthData),
                    RecurrencingYear(recurrenceYearData),
                  ]),
            )),
          ]),
        );
      }),
      actions: [
        FilledButton(
            onPressed: () {
              dataTransfered();
            },
            child: Text('OK')),
        FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error)),
      ],
    );
  }

  void dataTransfered() {
    Map<String, dynamic> content = {'type': null, 'data': null};
    switch (selectedTab) {
      case 0: //Day
        content['type'] = 'DAILY';
        content['data'] = recurrenceDayData;
        break;
      case 1: //Week
        content['type'] = 'WEEKLY';
        content['data'] = recurrenceWeekData;
        break;
      case 2: //Month
        content['type'] = 'MONTHLY';
        content['data'] = recurrenceMonthData;
        break;
      case 3: //Year
        content['type'] = 'YEARLY';
        content['data'] = recurrenceYearData;
        break;
    }
    Navigator.pop(context, content);
  }
}
