class Todo {
  String id;
  String title;
  bool isCompleted;
  DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });

  // JSON → Todo
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      title: json["title"],
      isCompleted: json["isCompleted"] ?? false,
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  // Todo → JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "isCompleted": isCompleted,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
