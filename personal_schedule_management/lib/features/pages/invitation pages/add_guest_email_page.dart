import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_schedule_management/features/controller/add_guest_email_controller.dart';

class AddGuestEmail extends StatefulWidget {
  AddGuestEmail(this.guestList, {super.key});
  List<String> guestList = [];
  @override
  State<AddGuestEmail> createState() => _AddGuestEmailState();
}

class _AddGuestEmailState extends State<AddGuestEmail> {
  List<String> guestList = [];
  AddGuestEmailController addGuestEmailController = AddGuestEmailController([]);

  @override
  void initState() {
    super.initState();
    guestList = widget.guestList;
    addGuestEmailController = AddGuestEmailController(guestList);
  }

  @override
  void dispose() {
    super.dispose();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thêm khách mời'),
          leading: InkWell(
            child: const Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: ListView.builder(
            itemCount: guestList.length + 1,
            itemBuilder: (context, index) {
              if (index < guestList.length) {
                return ListTile(
                  title: Row(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(guestList[index])),
                    const Spacer(),
                    InkWell(
                      child: const Icon(Icons.delete),
                      onTap: () async {
                        addGuestEmailController.removeEmail(index);
                        setState(() {});
                      },
                    )
                  ]),
                );
              } else {
                return InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Thêm khách mời'),
                  ),
                  onTap: () async {
                    addGuestEmailController.openAddEmailDialog(
                        context, () => setState(() {}));
                  },
                );
              }
            }));
  }
}
