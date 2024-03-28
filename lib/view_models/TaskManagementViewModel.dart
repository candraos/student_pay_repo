import '../models/database_helper.dart';
import '../models/task_management.dart';
import 'package:flutter/cupertino.dart';


class TaskManagementViewModel extends ChangeNotifier{
List<TaskManagement> tasks = [];

final DatabaseHelper _databaseHelper = DatabaseHelper();
double remaining = 0;

Future<void> loadTasks() async{
  List<Map<String, dynamic>> maps = await _databaseHelper.getTasks();
  tasks = List.generate(maps.length, (i) {
    return TaskManagement(
      id: maps[i]['id'],
      title: maps[i]['title'],
      description: maps[i]['description'],
      isChecked : maps[i]['isChecked'] ?? 0
    );
  });
  notifyListeners();
}
Future<int> delete(int id) async{
  return await _databaseHelper.delete("TaskManagement", id);

}
Future<void> addTask(TaskManagement taskManagement) async{
  await _databaseHelper.insertValue("TaskManagement", taskManagement.toJson());
  await loadTasks();
  notifyListeners();

}
Future<void> updateTask(int id, TaskManagement taskManagement) async{
  await _databaseHelper.updateById("TaskManagement", id, taskManagement.toJson());
  await loadTasks();
  notifyListeners();
}


}