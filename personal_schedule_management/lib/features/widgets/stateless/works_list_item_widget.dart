import 'package:flutter/material.dart';

class WorksListItem extends StatefulWidget {
  final String name;
  final String creator;
  bool isCompleted;

  WorksListItem(
      {required this.name, required this.creator, this.isCompleted = false});

  @override
  _WorksListItemState createState() => _WorksListItemState();
}

class _WorksListItemState extends State<WorksListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(widget.name, style: TextStyle(fontSize: 18)),
              Text(widget.creator),
            ],
          ),
          Checkbox(
            value: widget.isCompleted,
            onChanged: (value) {
              setState(() {
                widget.isCompleted = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
