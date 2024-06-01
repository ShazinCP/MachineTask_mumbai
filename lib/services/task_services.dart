import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mumbai_machinetask/model/task_model.dart';

class TaskServices {

    final CollectionReference firebaseTasks =
      FirebaseFirestore.instance.collection('task');

  Future<List<TaskModel>> fetchTasks() async {
    final snapshot = await firebaseTasks.get();
    return snapshot.docs.map((doc) {
      return TaskModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void addTask(TaskModel task) {
    final data = task.toMap();
    firebaseTasks.add(data);
  }

  void updateTask(TaskModel task) {
    final data = task.toMap();
    firebaseTasks.doc(task.id).update(data);
  }

  void deleteTask(String docId) {
    firebaseTasks.doc(docId).delete();
  }

    Future<void> updateTasks(String id, Map<String, dynamic> updates) async {
    await firebaseTasks.doc(id).update(updates);
  }
}
