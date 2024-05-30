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

  List<TaskModel> items = [];
  TaskServices taskServices = TaskServices();
  bool isLoading = true;

  //fetch todo
  Future<void> fetchTask() async {}

  //add todo
  Future<void> submitData() async {}

  //delete todo
  Future<void> deleteById(String id) async {}

  // update todo
  Future<void> updateData(TaskModel taskModel) async {}

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

}
