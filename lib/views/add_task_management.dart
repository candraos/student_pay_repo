import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/models/task_management.dart';
import 'package:flutter_budget_planning/view_models/TaskManagementViewModel.dart';

class AddTaskManagement extends StatefulWidget {
  const AddTaskManagement({super.key});

  @override
  State<AddTaskManagement> createState() => _AddTaskManagementState();
}

class _AddTaskManagementState extends State<AddTaskManagement> {

  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the task title';
                }
                return null;
              },

            ),



            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                 await TaskManagementViewModel().addTask(TaskManagement(title: _titleController.text.trim(), description: "",isChecked: 0));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task Added Successfully')),
                  );

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
