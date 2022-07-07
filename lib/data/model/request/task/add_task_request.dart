class AddTaskRequest {
  final String title;
  final String note;
  final int deadline;

  const AddTaskRequest({
    required this.title,
    required this.note,
    required this.deadline,
  });
}
