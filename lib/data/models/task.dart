import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  String id;
  String note;
  DateTime time;
  String category;

  Task({this.title, this.category, this.note, this.time, this.id});

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['id'] = id ?? '';
    map['title'] = title ?? '';
    map['note'] = note ?? '';
    map['category'] = category ?? "";

    map['time'] = time != null ? Timestamp.fromDate(time) :Timestamp.fromDate(DateTime.now());
    return map;
  }

  static Task fromJson(Map<String, dynamic> map){
    return Task(
      title: map['title'] ?? '',
      note: map['note'] ?? '',
      category: map['category'] ?? '',
      id: map['id'] ?? '',
      time: map['time']  != null? (map['time'] as Timestamp).toDate(): Timestamp.now().toDate(),
);
  }

  static List<Task> tasks = [
    Task(
        title: "Submit my proposal",
        note: "note",
        time: DateTime.now().subtract(Duration(days: 2)),
        category: "Study"),
    Task(
        title: "Draw buhari",
        note: "note",
        time: DateTime.now().subtract(Duration(days: 1)),
        category: "Art"),
    Task(
        title: "Travel to india",
        note: "note",
        time: DateTime.now().subtract(Duration(days: 1)),
        category: "Travel"),
    Task(
        title: "Buy a PS5",
        note: "note",
        time: DateTime.now().subtract(Duration(days: 1)),
        category: "Shopping"),
    Task(
        title: "Wash my feet",
        note: "note",
        time: DateTime.now(),
        category: "Home"),
    Task(
        title: "Practice Piano",
        note: "note",
        time: DateTime.now(),
        category: "Music"),
    Task(
        title: "Learn Spanish",
        note: "note",
        time: DateTime.now().add(Duration(days: 1)),
        category: "Study"),
    Task(
        title: "Go for shopping",
        note: "note",
        time: DateTime.now().add(Duration(days: 1)),
        category: "Shopping"),
    Task(
        title: "Read Chemistry",
        note: "note",
        time: DateTime.now().add(Duration(days: 1)),
        category: "Study"),
    Task(
        title: "Wash the car",
        note: "note",
        time: DateTime.now().add(Duration(days: 2)),
        category: "Home"),
  ];
}
