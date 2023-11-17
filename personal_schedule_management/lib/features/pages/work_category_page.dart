import 'package:flutter/material.dart';
import 'package:personal_schedule_management/features/controller/work_category_controller.dart';
import 'package:provider/provider.dart';

class WorkCategoryPage extends StatelessWidget {
  const WorkCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    WorkCategoryController controller =
        Provider.of<WorkCategoryController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Loại công việc'),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context, [controller.selectedValue]),
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
                    groupValue: controller.selectedValue,
                    onChanged: (value) {
                      controller.onValueChange(value as String);
                    },
                    title: Row(children: [
                      Text(data[index]),
                      Spacer(),
                      InkWell(
                        child: Icon(Icons.delete),
                        onTap: () {
                          controller.removeWorkCategory(index);
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
                      controller.openCreateWorkCategoryDialog(context);
                    },
                  );
                }
              });
        },
      ),
    );
  }
}
