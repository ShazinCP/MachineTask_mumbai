class TaskModel {
  String id;
  String title;
  String description;
  DateTime deadline;
  Duration expectedDuration;
  bool isComplete;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.expectedDuration,
    this.isComplete = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'expectedDuration': expectedDuration.inSeconds,
      'isComplete': isComplete,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      expectedDuration: Duration(seconds: map['expectedDuration']),
      isComplete: map['isComplete'] ?? false,
    );
  }
}
