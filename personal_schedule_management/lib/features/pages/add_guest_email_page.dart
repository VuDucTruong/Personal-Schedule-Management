// import 'package:flutter/material.dart';

// class AddGuestEmail extends StatefulWidget {
//   const AddGuestEmail({super.key});

//   @override
//   State<AddGuestEmail> createState() => _AddGuestEmailState();
// }

// class _AddGuestEmailState extends State<AddGuestEmail> {
//   String selectedValue = "email@email.com";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Thêm khách mời'),
//         leading: InkWell(
//           child: const Icon(Icons.arrow_back),
//           onTap: () => Navigator.pop(context),
//         ),
//       ),
//       body: FutureBuilder(
//         future: Future.delayed(
//             Duration.zero), //TODO: get data from some fucking shit
//         builder: (context, snapshot) {
//           List<String> data = [];
//           data.add(selectedValue); //testing
//           if (snapshot.hasData) data = snapshot.data!;
//           return ListView.builder(
//               itemCount: data.length + 1,
//               itemBuilder: (context, index) {
//                 if (index < data.length) {
//                   return RadioListTile(
//                     value: data[index],
//                     groupValue: selectedValue,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedValue = value as String;
//                       });
//                     },
//                     title: Row(children: [
//                       Text(data[index]),
//                       const Spacer(),
//                       InkWell(
//                         child: const Icon(Icons.delete),
//                         onTap: () async {
//                           //TODO: Delete Email
//                         },
//                       )
//                     ]),
//                   );
//                 } else {
//                   return InkWell(
//                     child: const ListTile(
//                       leading: Icon(Icons.add),
//                       title: Text('Thêm khách mời'),
//                     ),
//                     onTap: () {
//                       //TODO: add guest email
//                     },
//                   );
//                 }
//               });
//         },
//       ),
//     );
//     ;
//   }
// }
