import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/controller/work_category_controller.dart';

class WorkCategoryPage extends StatefulWidget {
  WorkCategoryPage(this.selectedCategory, {super.key});
  String selectedCategory;
  @override
  State<WorkCategoryPage> createState() => _WorkCategoryPageState();
}

class _WorkCategoryPageState extends State<WorkCategoryPage> {
  String selectedValue = 'Không có';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedCategory;
  }

  WorkCategoryController controller = WorkCategoryController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Loại công việc'),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context, [selectedValue]),
        ),
      ),
      body: FutureBuilder(
        future: controller.getWorkCategoryList(),
        builder: (context, snapshot) {
          List<String> data = [];
          if (snapshot.hasData) data = snapshot.data!;
          return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index < data.length) {
                  return RadioListTile(
                    value: data[index],
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    title: Row(children: [
                      Text(data[index]),
                      Spacer(),
                      InkWell(
                        child: Icon(Icons.delete),
                        onTap: () async {
                          await controller.removeWorkCategory(index);
                          setState(() {});
                        },
                      )
                    ]),
                  );
                } else {
                  return InkWell(
                    child: ListTile(
                      leading: Icon(Icons.add),
                      title: Text('Thêm loại công việc'),
                    ),
                    onTap: () {
                      controller.openCreateWorkCategoryDialog(
                        context,
                            () => setState(() {}),
                      );
                    },
                  );
                }
              });
        },
      ),
    );
  }
}