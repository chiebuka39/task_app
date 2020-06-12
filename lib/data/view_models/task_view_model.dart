import 'package:flutter/foundation.dart';
import 'package:task_app/data/data_result.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/locator.dart';

import '../repo/tasks_api.dart';

abstract class AbstractTaskViewModel extends ChangeNotifier{
  List<Task> _tasks;
  List<Task> get tasks => _tasks;

  set tasks(List<Task> value);

  Future<DataResult<void>> createTask(Task task);
  Future<DataResult<void>> editTask(Task task);
  Future<DataResult<List<Task>>> fetchAllTasks();
  Stream<List<Task>> listenForTasks();
}

class TaskViewModel extends AbstractTaskViewModel{
  final  _api = locator<AbstractTaskApi>();
  @override
  void set tasks(List<Task> value) {
    _tasks= value;
    notifyListeners();
  }

  @override
  Future<DataResult<void>> createTask(Task task) {
    return _api.createTask(task);
  }

  @override
  Future<DataResult<void>> editTask(Task task) {
    // TODO: implement editTask
    return null;
  }

  @override
  Future<DataResult<List<Task>>> fetchAllTasks() {
    return _api.fetchAllTasks();
  }

  @override
  Stream<List<Task>> listenForTasks() {
    return _api.listenForTasks();
  }

}