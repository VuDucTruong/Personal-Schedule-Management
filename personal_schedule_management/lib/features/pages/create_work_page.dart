import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/controller/create_work_controller.dart';
import 'package:personal_schedule_management/features/pages/work_category_page.dart';
import 'package:provider/provider.dart';

import '../../core/domain/entity/cong_viec_entity.dart';

class CreateWorkPage extends StatefulWidget {
  const CreateWorkPage({super.key});

  @override
  _CreateWorkPageState createState() {
    return _CreateWorkPageState();
  }
}

class _CreateWorkPageState extends State<CreateWorkPage> {
  late TextEditingController titleController,
      descriptionController,
      locationController,
      urlController;
  final _formKey = GlobalKey<FormState>();
  List<Color> colorList = [
    lightColorScheme.primary,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.orangeAccent
  ];
  @override
  void initState() {
    super.initState();
    Provider.of<CreateWorkController>(context, listen: false).resetData();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    urlController = TextEditingController();
  }

  DateFormat dayFormat = DateFormat("dd/MM/yyyy", 'vi_VN');
  DateFormat time12Format = DateFormat("hh:mm a", 'vi_VN');
  DateFormat time24Format = DateFormat("HH:mm", 'vi_VN');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(8),
      height: height * 5 / 6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 4, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(FontAwesomeIcons.arrowLeftLong,
                        color: lightColorScheme.primary),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Công việc',
                    style: AppTextStyle.h2,
                  ),
                  Consumer<CreateWorkController>(
                    builder: (context, controller, child) => InkWell(
                      child: Icon(FontAwesomeIcons.check,
                          color: lightColorScheme.primary),
                      onTap: () async {
                        try {
                          if (!_formKey.currentState!.validate()) return;
                        } catch (e) {
                          return;
                        }

                        CongViec congViec = CongViec(
                            '',
                            '',
                            '',
                            titleController.text,
                            descriptionController.text,
                            controller.selectedValue,
                            controller.startDate!,
                            controller.endDate!,
                            controller.allDaySwitch,
                            0,
                            2,
                            controller.colorIcon,
                            locationController.text,
                            urlController.text,
                            false);
                        if (await controller.createWork(congViec))
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Thêm thành công')));
                        else
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Thêm thất bại')));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.all(4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: titleController,
                              validator: (value) {
                                if (value != null && value.isNotEmpty)
                                  return null;
                                else
                                  return 'Không được bỏ trống !';
                              },
                              maxLines: 2,
                              minLines: 1,
                              decoration: InputDecoration(
                                  hintText: 'Tiêu đề',
                                  border: InputBorder.none),
                              style: AppTextStyle.h2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      child: TextFormField(
                        controller: descriptionController,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                            hintText: 'Thêm chi tiết',
                            border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ),
            OptionWork()
          ],
        ),
      ),
    );
  }

  Widget OptionWork() {
    int index = 0;
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                ListTitleWork(
                    Text('Loại công việc'),
                    Icons.category,
                    Consumer<CreateWorkController>(
                      builder: (context, controller, child) => InkWell(
                        child: Container(
                          width: 120,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.selectedValue,
                                  style: AppTextStyle.h2_5
                                      .copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                        onTap: () async {
                          List<String> result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkCategoryPage()),
                          );
                          controller.changeStringValue(result.first);
                        },
                      ),
                    )),
                DividerWorkItem(),
                ListTitleWork(
                    Text('Cả ngày'),
                    FontAwesomeIcons.stopwatch,
                    Consumer<CreateWorkController>(
                      builder: (context, controller, child) => Switch(
                        onChanged: (value) {
                          controller.changeAllDaySwitch(value);
                        },
                        value: controller.allDaySwitch,
                        activeColor: controller.colorIcon,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Consumer<CreateWorkController>(
                    builder: (context, controller, child) => Column(
                      children: [
                        ListTitleWork(
                            GestureDetector(
                              child: Text(toDayString(controller.startDate)),
                              onTap: () {
                                controller.pickUpStartDate(context);
                              },
                            ),
                            FontAwesomeIcons.arrowRight,
                            Visibility(
                              visible: !controller.allDaySwitch,
                              child: GestureDetector(
                                child: Text(
                                  toTimeString(controller.startDate),
                                  style: AppTextStyle.h2_5,
                                ),
                                onTap: () {
                                  controller.pickUpStartTime(context);
                                },
                              ),
                            )),
                        ListTitleWork(
                            GestureDetector(
                              child: Text(toDayString(controller.endDate)),
                              onTap: () {
                                controller.pickUpEndDate(context);
                              },
                            ),
                            FontAwesomeIcons.arrowLeft,
                            Visibility(
                              visible: !controller.allDaySwitch,
                              child: GestureDetector(
                                child: Text(
                                  toTimeString(controller.endDate),
                                  style: AppTextStyle.h2_5,
                                ),
                                onTap: () {
                                  controller.pickUpEndTime(context);
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DividerWorkItem(),
          Container(
            child: Column(
              children: [
                ListTitleWork(
                    Text('Thiết lập nhắc nhở'),
                    Icons.message,
                    Consumer<CreateWorkController>(
                      builder: (context, controller, child) => Switch(
                        onChanged: (value) {
                          controller.changeReminderSwitch(value);
                        },
                        value: controller.reminderSwitch,
                        activeColor: controller.colorIcon,
                      ),
                    )),
                Consumer<CreateWorkController>(
                    builder: (context, controller, child) {
                  int max = controller.reminderTimeList.length + 1;
                  return Visibility(
                    visible: controller.reminderSwitch,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: max,
                        itemBuilder: (context, index) {
                          if (index == max - 1)
                            return GestureDetector(
                              child: ListTitleWork(Text('Thêm nhắc nhở'),
                                  FontAwesomeIcons.plus, null),
                              onTap: () {
                                controller.insertReminderTime(context);
                              },
                            );
                          return ListTitleWork(
                              Text(controller.reminderTimeList[index]),
                              FontAwesomeIcons.clock,
                              InkWell(
                                child: Icon(FontAwesomeIcons.xmark),
                                onTap: () {
                                  controller.deleteReminderTime(index);
                                },
                              ));
                        },
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          DividerWorkItem(),
          ListTitleWork(
              Text('Lời nhắc báo thức'),
              Icons.alarm,
              Consumer<CreateWorkController>(
                builder: (context, controller, child) => Switch(
                  value: controller.alarmSwitch,
                  onChanged: (value) {
                    controller.changeAlarmSwitch(value);
                  },
                  activeColor: controller.colorIcon,
                ),
              )),
          DividerWorkItem(),

          //TODO
          Consumer<CreateWorkController>(
            builder: (context, controller, child) => Builder(
              builder: (context) {
                if (controller.loop != null) {
                  return Column(
                    children: [
                      ListTitleWork(
                          Text(controller.contentRecurrence[0]),
                          Icons.repeat,
                          InkWell(
                            child: Icon(FontAwesomeIcons.xmark),
                            onTap: () {
                              controller.removeLoop();
                            },
                          )),
                      DividerWorkItem(),
                      ListTitleWork(Text(controller.contentRecurrence[1]),
                          FontAwesomeIcons.calendarXmark, null),
                    ],
                  );
                } else {
                  return GestureDetector(
                    child: ListTitleWork(
                        Text('Không lặp lại'), Icons.repeat, null),
                    onTap: () {
                      controller.openRecurringDialog(context);
                    },
                  );
                }
              },
            ),
          ),

          DividerWorkItem(),
          Container(
            child: Column(
              children: [
                ListTitleWork(Text('Màu sắc'), Icons.palette, null),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...colorList.map((e) => CustomColorRadio(index++, e))
                  ],
                )
              ],
            ),
          ),
          DividerWorkItem(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: locationController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Selector<CreateWorkController, Color>(
                    selector: (p0, p1) => p1.colorIcon,
                    builder: (context, value, child) => Icon(
                      Icons.location_on,
                      color: value,
                    ),
                  ),
                  hintText: 'Vị trí'),
            ),
          ),
          DividerWorkItem(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: urlController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Selector<CreateWorkController, Color>(
                    selector: (p0, p1) => p1.colorIcon,
                    builder: (context, value, child) => Icon(
                      Icons.link,
                      color: value,
                    ),
                  ),
                  hintText: 'URL'),
            ),
          )
        ],
      ),
    );
  }

  String toDayString(DateTime? day) {
    return dayFormat.format(day!);
  }

  String toTimeString(DateTime? time) {
    return time24Format.format(time!);
  }

  Widget ListTitleWork(
      Widget contentWidget, IconData leadingIcon, Widget? trailingWidget) {
    return Consumer<CreateWorkController>(
      builder: (context, controller, child) => ListTile(
        title: contentWidget,
        leading: Icon(
          leadingIcon,
          color: controller.colorIcon,
        ),
        trailing: trailingWidget,
      ),
    );
  }
}

class CustomColorRadio extends StatelessWidget {
  int index;
  Color color;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<CreateWorkController>(
      builder: (context, controller, child) {
        return OutlinedButton(
            onPressed: () {
              controller.onChangedColorRadio(color);
            },
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(0),
                minimumSize: Size.fromRadius(14),
                side: BorderSide(
                    width: 2,
                    color: (controller.colorIcon == color)
                        ? Colors.greenAccent
                        : Colors.transparent),
                shape: CircleBorder()),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45), color: color),
            ));
      },
    );
  }

  CustomColorRadio(this.index, this.color, {super.key});
}

class DividerWorkItem extends StatelessWidget {
  const DividerWorkItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.5,
      indent: 12,
      endIndent: 12,
    );
  }
}
