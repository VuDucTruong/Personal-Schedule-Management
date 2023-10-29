import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/controller/create_work_controller.dart';
import 'package:provider/provider.dart';

Color iconColor = lightColorScheme.primary;

class CreateWorkPage extends StatefulWidget {
  const CreateWorkPage({super.key});

  @override
  _CreateWorkPageState createState() {
    return _CreateWorkPageState();
  }
}

class _CreateWorkPageState extends State<CreateWorkPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  Icon(FontAwesomeIcons.check, color: lightColorScheme.primary),
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
                          child: TextFormField(
                            maxLines: 2,
                            minLines: 1,
                            decoration: InputDecoration(
                                hintText: 'Tiêu đề', border: InputBorder.none),
                            style: AppTextStyle.h2,
                          ),
                        ),
                        Column(
                          children: [
                            FilledButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.add,
                              ),
                              style: FilledButton.styleFrom(
                                  shape: CircleBorder(),
                                  minimumSize: Size.fromRadius(20)),
                            ),
                            Text(
                              'Loại công việc',
                              style: AppTextStyle.normal,
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 100,
                      child: TextFormField(
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
}

class OptionWork extends StatelessWidget {
  const OptionWork({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int max = 2;
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                ListTitleWork(
                    'Cả ngày',
                    FontAwesomeIcons.stopwatch,
                    Switch(
                      onChanged: (_) {},
                      value: false,
                    )),
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      ListTitleWork(
                          DateTime.now().toString(),
                          FontAwesomeIcons.arrowRight,
                          Text(
                            '12:12',
                            style: AppTextStyle.normal,
                          )),
                      ListTitleWork(
                          DateTime.now().toString(),
                          FontAwesomeIcons.arrowLeft,
                          Text(
                            '13:12',
                            style: AppTextStyle.normal,
                          )),
                    ],
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
                    'Thiết lập nhắc nhở',
                    Icons.message,
                    Switch(
                      onChanged: (_) {},
                      value: false,
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: max,
                    itemBuilder: (context, index) {
                      if (index == max - 1)
                        return ListTitleWork(
                            'Thêm nhắc nhở', FontAwesomeIcons.plus, null);
                      return ListTitleWork('Trước 15p', FontAwesomeIcons.clock,
                          Icon(FontAwesomeIcons.xmark));
                    },
                  ),
                )
              ],
            ),
          ),
          DividerWorkItem(),
          ListTitleWork(
              'Lời nhắc báo thức',
              Icons.alarm,
              Switch(
                value: false,
                onChanged: (_) {},
              )),
          DividerWorkItem(),
          ListTitleWork('Không lặp lại', Icons.repeat, null),
          DividerWorkItem(),
          Container(
            child: Column(
              children: [
                ListTitleWork(
                    'Màu sắc', Icons.palette, Icon(Icons.arrow_forward_ios)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomColorRadio(0, Colors.red),
                    CustomColorRadio(1, Colors.blue),
                    CustomColorRadio(2, Colors.greenAccent),
                    CustomColorRadio(3, Colors.yellow),
                    CustomColorRadio(4, Colors.orangeAccent),
                  ],
                )
              ],
            ),
          ),
          DividerWorkItem(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.location_on,
                    color: iconColor,
                  ),
                  hintText: 'Vị trí'),
            ),
          ),
          DividerWorkItem(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.link,
                    color: iconColor,
                  ),
                  hintText: 'URL'),
            ),
          )
        ],
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
              controller.onChangedColorRadio(index);
            },
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(0),
                minimumSize: Size.fromRadius(14),
                side: BorderSide(
                    width: 2,
                    color: (controller.selectedColorRadio == index)
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

class ListTitleWork extends StatelessWidget {
  String content;
  IconData leadingIcon;
  Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(content),
      leading: Icon(
        leadingIcon,
        color: iconColor,
      ),
      trailing: trailingWidget,
    );
  }

  ListTitleWork(this.content, this.leadingIcon, this.trailingWidget,
      {super.key});
}
