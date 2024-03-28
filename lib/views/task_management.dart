import 'package:flutter/material.dart';
import 'package:flutter_budget_planning/view_models/TaskManagementViewModel.dart';
import 'package:flutter_budget_planning/views/add_task_management.dart';
import 'package:provider/provider.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final  taskManagementViewModel = Provider.of<TaskManagementViewModel>(context);
    return Scaffold(
      body: FutureBuilder<void>(
        future: taskManagementViewModel.loadTasks(),
        builder: (context,snapshot) {

          return Consumer<TaskManagementViewModel>(
            builder: (context,taskManagementViewModel,child) {
              return ListView.builder(
                itemCount: taskManagementViewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskManagementViewModel.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    leading: Checkbox(
                      tristate: true,
                      value: task.isChecked == 1? true : false,
                      onChanged: (bool? value) async{
                          task.isChecked = value == null? 0 : value == true? 1 : 0;
                          await taskManagementViewModel.updateTask(task.id!, task);

                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async{
                        await taskManagementViewModel.delete(task.id!);
                        setState(() {

                        });
                      },
                    ),
                  );
                },
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskManagement()));
    },
    child: Icon(Icons.add),
    )
    );
  }
}
