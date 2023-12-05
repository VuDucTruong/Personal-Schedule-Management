import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/widgets/stateful/create_reminder_dialog.dart';

class ReminderDialog extends StatelessWidget {
  ReminderDialog(this.isAllDay, this.reminder_list, {super.key});
  bool isAllDay;
  List<String> reminder_list;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      content: Container(
        height: 300,
        width: 400,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: reminder_list.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              value: false,
              title: Text(reminder_list[index]),
              onChanged: (_) async {
                if (index < reminder_list.length - 1) {
                  List<String> splittedTime = reminder_list[index].split(' ');
                  int period = int.tryParse(splittedTime[1]) ?? 0;
                  Duration pickedDuration;
                  if (isAllDay) {
                    switch (splittedTime[2]) {
                      case 'ngày':
                        break;
                      case 'tuần':
                        period *= 7;
                        break;
                    }
                    // Chuyen doi thanh ngay

                    pickedDuration = Duration(days: period);
                    Navigator.pop(
                        context, [reminder_list[index], pickedDuration]);
                    return;
                  }
                  switch (splittedTime[2]) {
                    case 'phút':
                      pickedDuration = Duration(minutes: period);
                      break;
                    case 'giờ':
                      pickedDuration = Duration(hours: period);
                      break;
                    case 'ngày':
                      pickedDuration = Duration(days: period);
                      break;
                    default:
                      pickedDuration = Duration.zero;
                  }
                  Navigator.pop(
                      context, [reminder_list[index], pickedDuration]);
                } else {
                  List<dynamic>? results = await showDialog(
                    context: context,
                    builder: (context) {
                      return CreateReminderDialog(isAllDay);
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
