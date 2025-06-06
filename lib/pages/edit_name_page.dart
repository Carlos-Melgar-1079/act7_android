import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1743253073.
class editNamePage extends StatefulWidget {
  const editNamePage({super.key});

  @override
  State<editNamePage> createState() => _editNamePageState();
}

class _editNamePageState extends State<editNamePage> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Name"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'ingresa la modificacion',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updatePeople(arguments['uid'], nameController.text).then((
                  _,
                ) {
                  Navigator.pop(context);
                });
              },
              child: const Text("actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
