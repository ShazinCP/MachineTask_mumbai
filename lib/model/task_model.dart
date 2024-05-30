class TaskModel {
  String title;
  String description;
  DateTime deadline;
  Duration expectedDuration;
  bool isComplete;

  TaskModel({
    required this.title,
    required this.description,
    required this.deadline,
    required this.expectedDuration,
    this.isComplete = false,
  });
}
