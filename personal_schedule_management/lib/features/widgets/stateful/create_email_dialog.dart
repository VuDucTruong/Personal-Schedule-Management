import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_schedule_management/features/controller/add_guest_email_controller.dart';

class AddEmailDialog extends StatefulWidget {
  AddEmailDialog(this.addGuestEmailController, this.setStateCallBack,
      {super.key});
  AddGuestEmailController addGuestEmailController;
  VoidCallback setStateCallBack;
  @override
  State<AddEmailDialog> createState() => _AddEmailDialogState();
}

class _AddEmailDialogState extends State<AddEmailDialog> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isValidEmail = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: Text('Thêm Email',
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\n"))],
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (EmailValidator.validate(value)) {
                isValidEmail = true;
                return null;
              } else {
                isValidEmail = false;
                return 'Email không hợp lệ';
              }
            } else {
              isValidEmail = false;
              return 'Vui lòng nhập email';
            }
          },
          maxLines: 1,
          maxLength: 30,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          decoration: InputDecoration(
              hintText: 'Email...',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey, width: 1))),
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () async {
              _formKey.currentState!.validate();
              setState(() {});
              String email = controller.text;
              if (!isValidEmail) return;
              if (await widget.addGuestEmailController.addEmail(email)) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm thất bại!',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)),
                      content: Text(
                        'Email đã tồn tại hoặc không có người dùng nào sử dụng email này',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    );
                  },
                );
              }
              widget.setStateCallBack();
            },
            child: const Text('Đồng ý')),
        FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Hủy'))
      ],
    );
  }
}
