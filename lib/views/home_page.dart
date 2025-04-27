// /screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:cpad_assignment_neha/services/parse_service.dart';
import 'package:cpad_assignment_neha/models/assignmentClass.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  List<AssignmentClass> records = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    final data = await ParseService.getRecords();
    setState(() {
      records = data;
    });
  }

  Future<void> addRecord() async {
    final name = nameController.text.trim();
    final ageText = ageController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || ageText.isEmpty || email.isEmpty || int.tryParse(ageText) == null) {
      showError('Valid Name, Email and numeric Age are required.');
      return;
    }

    await ParseService.createRecord(name, int.parse(ageText), email);
    nameController.clear();
    ageController.clear();
    emailController.clear();
    fetchRecords();
  }

  Future<void> updateRecord(AssignmentClass record) async {
    final newName = await inputDialog('Update Name', record.name);
    final newAge = await inputDialog('Update Age', record.age.toString());
    final email = await inputDialog('Update Email', record.email);

    if (newName == null || newAge == null || email == null || newName.trim().isEmpty || int.tryParse(newAge) == null) {
      showError('Valid Name, Email and numeric Age are required.');
      return;
    }

    await ParseService.updateRecord(record.id!, newName.trim(), int.parse(newAge), email.trim());
    fetchRecords();
  }

  Future<void> deleteRecord(AssignmentClass record) async {
    await ParseService.deleteRecord(record.id!);
    fetchRecords();
  }

  void showError(String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'))
          ],
        ));
  }

  Future<String?> inputDialog(String title, String initialValue) async {
    final controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, null), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await ParseService.logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: ageController,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addRecord,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ListTile(
                    title: Text('${record.name}, Age: ${record.age}, Email: ${record.email}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => updateRecord(record),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteRecord(record),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
