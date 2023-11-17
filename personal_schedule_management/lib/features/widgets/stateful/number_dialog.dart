import 'package:flutter/material.dart';

class NumberDialog extends StatefulWidget {
  NumberDialog(this.seletecNumber, {super.key});
  String seletecNumber;
  @override
  _NumberDialogState createState() {
    return _NumberDialogState();
  }
}

class _NumberDialogState extends State<NumberDialog> {
  final List<String> number = List.generate(6, (index) => '${index + 1}');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      content: Container(
        height: 300,
        child: ListView(
          children: [
            ...number.map((e) => RadioListTile(
                title: Text(e),
                value: e,
                groupValue: widget.seletecNumber,
                onChanged: (number) {
                  setState(() {
                    widget.seletecNumber = e;
                    Navigator.pop(context, widget.seletecNumber);
                  });
                }))
          ],
        ),
      ),
    );
  }
}
