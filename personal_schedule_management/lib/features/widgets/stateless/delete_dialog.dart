import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: Size(250, 35)),
            onPressed: () {
              Navigator.pop(context, 2);
            },
            child: Text('Chỉ xóa công việc này')),
        OutlinedButton(
            style: OutlinedButton.styleFrom(minimumSize: Size(250, 35)),
            onPressed: () {
              Navigator.pop(context, 1);
            },
            child: Text('Xóa công việc lặp lại')),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                minimumSize: Size(250, 35), backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context, 0);
            },
            child: Text('Hủy'))
      ],
    );
  }
}
