import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test/UserTextField.dart';
import 'package:test/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditableUserPage extends StatefulWidget {
  final String name, org, txt, Date;

  const EditableUserPage({
    Key? key,
    required this.name,
    required this.org,
    required this.txt,
    required this.Date,
  }) : super(key: key);

  @override
  _EditableUserPageState createState() => _EditableUserPageState();
}

class _EditableUserPageState extends State<EditableUserPage> {
  bool showText = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7), () {
      setState(() {
        showText = false;
      });
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Pallete.blackColor,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Image.asset("assets/logo.jpg"),
          const SizedBox(height: 50),
          const Text(
            "Details",
            style: TextStyle(
              color: Pallete.whiteColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          UserTextField(label: "Name", showText: widget.name), // for username
          const SizedBox(height: 10),
          UserTextField(label: "Organization", showText: widget.org), // for user org
          const SizedBox(height: 10),
          UserTextField(label: "Completion Date", showText: widget.Date), // for user course
          const SizedBox(height: 10),
          if (showText)
            Text(
              widget.txt,
              style: const TextStyle(
                color: Pallete.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          const Spacer(), // Add a spacer to push the button to the bottom
          ElevatedButton(
            onPressed: () {
              saveDataToFirebase();
            },
            child: const Text('Save'),
          ),
          const SizedBox(height: 20), // Add some spacing after the button
        ],
      ),
    ),
  );
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<void> saveDataToFirebase() async {
  try {
    
    final CollectionReference collectionRef = _firestore.collection('texts');

    // Create a map with the data to be saved
    Map<String, dynamic> data = {
      'name': widget.name,
      'org': widget.org,
      'date': widget.Date,
   
    };

    // Add the data to Firestore
    await collectionRef.add(data);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved to Firebase')),
    );
  } catch (e) {
    print('Error saving data to Firebase: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to save data to Firebase')),
    );
  }
}

}
