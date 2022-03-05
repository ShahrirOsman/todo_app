class Todo {
  String? text;
  DateTime? startDateTime;
  DateTime? endDateTime;
  bool done;
  bool allDay;

  Todo({
    this.text,
    this.startDateTime,
    this.endDateTime,
    this.done = false,
    this.allDay = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        text: json['text'],
        startDateTime: json["startDateTime"] != null
            ? DateTime.parse(json["startDateTime"])
            : null,
        endDateTime: json["endDateTime"] != null
            ? DateTime.parse(json["endDateTime"])
            : null,
        done: json['done'],
        allDay: json['allDay'],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        "startDateTime":
            startDateTime != null ? startDateTime!.toIso8601String() : null,
        'endDateTime':
            endDateTime != null ? endDateTime!.toIso8601String() : null,
        'done': done,
        'allDay': allDay,
      };
}
