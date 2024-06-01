import 'package:flutter/material.dart';
import 'package:mumbai_machinetask/model/task_model.dart';
import 'package:mumbai_machinetask/services/task_services.dart';

class TaskProvider extends ChangeNotifier {
  bool isEdit = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime deadline = DateTime.now();
  Duration expectedDuration = const Duration(hours: 1);
  bool isComplete = false;
  bool isLoading = true;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void isEditValueChange(bool value) {
    isEdit = value;
  }

  void selectedDeadline(DateTime value) {
    deadline = value;
    notifyListeners();
  }

  void selectedExpectedDuration(Duration value) {
    expectedDuration = value;
    notifyListeners();
  }

  void seletedIsComplete(bool value) {
    isComplete = value;
    notifyListeners();
  }

  ///CRUD
 List<TaskModel> tasks = [];
  TaskServices taskServices = TaskServices();

  Future<void> fetchTasks() async {
    tasks = await taskServices.fetchTasks();
    notifyListeners();
  }

  void addTask() async {
    final addTask = TaskModel(
      id: "",
      title: titleController.text,
      description: descriptionController.text,
      deadline: deadline,
      expectedDuration: expectedDuration,
      isComplete: isComplete,
    );
    taskServices.addTask(addTask);
    await fetchTasks();
    notifyListeners();
  }

  Future<void> deleteTask(String docId) async {
    taskServices.deleteTask(docId);
    await fetchTasks();
    notifyListeners();
  }

  void updateTask(String docId) async {
    final updateTask = TaskModel(
      id: "",
      title: titleController.text,
      description: descriptionController.text,
      deadline: deadline,
      expectedDuration: expectedDuration,
      isComplete: isComplete,
    );
    taskServices.updateTask(updateTask);
    await fetchTasks();
    notifyListeners();
  }

  Future<void> updateTaskCompletionStatus(String id, bool isComplete) async {
    for (var task in tasks) {
      if (task.id == id) {
        task.isComplete = isComplete;
        break;
      }
    }
     taskServices.updateTasks(id, {'isComplete': isComplete});
    notifyListeners();
  }

}
