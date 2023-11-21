import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/widgets/stateful/create_reminder_dialog.dart';

class ReminderDialog extends StatelessWidget {
  ReminderDialog(this.isAllDay, this.reminder_list, this.startDate,
      {super.key});
  bool isAllDay;
  List<String> reminder_list;
  DateTime startDate;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      content: Container(
        height: 300,
        child: ListView.builder(
          itemCount: reminder_list.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              value: false,
              title: Text(reminder_list[index]),
              onChanged: (_) async {
                if (index < reminder_list.length - 1) {
                  List<String> splittedTime = reminder_list[index].split(' ');
                  int period = int.tryParse(splittedTime[1]) ?? 0;
                  DateTime pickedDate;
                  if (isAllDay) {
                    switch (splittedTime[2]) {
                      case 'ngày':
                        break;
                      case 'tuần':
                        period *= 7;
                        break;
                    }
                    // Chuyen doi thanh ngay

                    pickedDate = startDate
                        .copyWith(hour: 9, minute: 0)
                        .subtract(Duration(days: period));
                    Navigator.pop(context, [reminder_list[index], pickedDate]);
                    return;
                  }
                  switch (splittedTime[2]) {
                    case 'phút':
                      pickedDate =
                          startDate.subtract(Duration(minutes: period));
                      break;
                    case 'giờ':
                      pickedDate = startDate.subtract(Duration(hours: period));
                      break;
                    case 'ngày':
                      pickedDate = startDate.subtract(Duration(days: period));
                      break;
                    default:
                      pickedDate = startDate;
                  }
                  Navigator.pop(context, [reminder_list[index], pickedDate]);
                } else {
                  List<dynamic> results = await showDialog(
                    context: context,
                    builder: (context) {
                      return CreateReminderDialog(isAllDay, startDate);
                    },
                  );
                  if (!context.mounted) return;
                  Navigator.pop(context, results);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
