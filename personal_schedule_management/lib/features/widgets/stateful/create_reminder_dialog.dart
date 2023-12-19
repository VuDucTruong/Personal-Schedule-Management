import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';

class CreateReminderDialog extends StatefulWidget {
  CreateReminderDialog(this.isAllDay, {super.key});
  bool isAllDay;
  @override
  State<CreateReminderDialog> createState() => _CreateReminderDialogState();
}

class _CreateReminderDialogState extends State<CreateReminderDialog> {
  final List<String> options = ['Phút', 'Giờ', 'Ngày', 'Tuần'];
  final List<String> optionsAllDay = ['Ngày', 'Tuần'];
  late String isSelected;
  final _key = GlobalKey<FormState>();
  String durationValue = '1';
  TimeOfDay timeOfDay = TimeOfDay(hour: 9, minute: 0);
  late Duration pickedDuration;
  @override
  void initState() {
    if (!widget.isAllDay)
      isSelected = options.first;
    else
      isSelected = optionsAllDay.first;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text('Thông báo tùy chỉnh',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.isNotEmpty)
                    return null;
                  else
                    return 'Không được bỏ trống !';
                },
                initialValue: durationValue,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLines: 1,
                maxLength: 3,
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey))),
                onChanged: (text) {
                  durationValue = text;
                },
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 8,
              endIndent: 8,
            ),
            Builder(
              builder: (context) {
                if (!widget.isAllDay) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...options.map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                  value: e,
                                  groupValue: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      isSelected = value!;
                                    });
                                  }),
                              Text(e, style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground
                              )),
                            ],
                          )),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...optionsAllDay.map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                  value: e,
                                  groupValue: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      isSelected = value!;
                                    });
                                  }),
                                Text(e, style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground
                                )),
                            ],
                          )),
                      Divider(
                        color: Colors.grey,
                        indent: 8,
                        endIndent: 8,
                      ),
                      InkWell(
                        child: Text(
                          'Lúc ${timeOfDay.hour}:${timeOfDay.minute.toString().padLeft(2, '0')}',
                          style: AppTextStyle.h2_5.copyWith(
                            color: Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                        onTap: () async {
                          timeOfDay = await showTimePicker(
                                  context: context, initialTime: timeOfDay) ??
                              timeOfDay;
                          setState(() {});
                        },
                      )
                    ],
                  );
                }
              },
            ),
            Divider(
              color: Colors.grey,
              indent: 8,
              endIndent: 8,
            )
          ],
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () {
              _key.currentState?.validate();
              String time = '';
              int period = int.tryParse(durationValue) ?? 0;
              if (durationValue.isNotEmpty) {
                if (widget.isAllDay) {
                  switch (optionsAllDay.indexOf(isSelected)) {
                    case 0:
                      time = 'ngày';
                      break;
                    case 1:
                      time = 'tuần';
                      period *= 7;
                      break;
                  }
                  // Chuyen doi thanh ngay

                  pickedDuration = Duration(days: period);
                  Navigator.pop(context, [
                    'Trước $durationValue $time lúc ${timeOfDay.hour}:${timeOfDay.minute.toString().padLeft(2, '0')}',
                    pickedDuration
                  ]);
                  return;
                }
                switch (options.indexOf(isSelected)) {
                  case 0:
                    time = 'Phút';
                    pickedDuration = Duration(minutes: period);
                    break;
                  case 1:
                    time = 'Giờ';
                    pickedDuration = Duration(hours: period);
                    break;
                  case 2:
                    time = 'Ngày';
                    pickedDuration = Duration(days: period);
                    break;
                  case 3:
                    time = 'Tuần';
                    pickedDuration = Duration(days: period * 7);
                    break;
                }
                Navigator.pop(
                    context, ['Trước $durationValue $time', pickedDuration]);
              }
            },
            child: Text('OK'))
      ],
    );
  }
}
