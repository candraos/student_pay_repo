class TaskManagement{
  int? id;
  String title;
  String description;
  int isChecked = 0;

  TaskManagement({this.id, required this.title, required this.description,this.isChecked = 0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isChecked' : isChecked
    };
  }

  factory TaskManagement.fromJson(Map<String, dynamic> json) {
    return TaskManagement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isChecked: json['isChecked']
    );
  }
}