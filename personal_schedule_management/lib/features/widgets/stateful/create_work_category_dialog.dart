import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/controller/work_category_controller.dart';

import '../../../config/text_styles/app_text_style.dart';

class WorkCategoryDialog extends StatefulWidget {
  WorkCategoryDialog(this.workCategoryController, this.setStateCallBack,
      {super.key});
  WorkCategoryController workCategoryController;
  VoidCallback setStateCallBack;
  @override
  State<WorkCategoryDialog> createState() => _WorkCategoryDialogState();
}

class _WorkCategoryDialogState extends State<WorkCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    // TODO: implement build
    return AlertDialog(
      title: Text('Tạo loại công việc',
        style: TextStyle(color: Theme.of(context).colorScheme.primary)
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r"\n"))
          ],
          validator: (value) {
            if (value != null && value.isNotEmpty)
              return null;
            else
              return 'Vui lòng nhập loại công việc';
          },
          maxLines: 2,
          maxLength: 20,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          decoration: InputDecoration(
              hintText: 'Tên loại công việc...',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey, width: 1))),
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () async {
              _formKey.currentState!.validate();
              setState(() {});
              String category = controller.text;
              if (category.isEmpty) return;
              if (await widget.workCategoryController
                  .insertWorkCategory(category)) {
                Navigator.pop(context);
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text('Thêm thành công!')));
              } else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm thất bại!',
                        style: TextStyle(color: Theme.of(context).colorScheme.error)
                      ),
                      content: Text(
                        'Loại công việc bạn vừa nhập đã tồn tại hoặc do lỗi hệ thống',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    );
                  },
                );
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text('Thêm thất bại!')));
              }
              widget.setStateCallBack();
            },
            child: Text('Đồng ý')),
        FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style:
            FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            child: Text('Hủy'))
      ],
    );
  }
}