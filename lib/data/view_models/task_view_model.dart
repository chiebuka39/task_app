import 'package:flutter/foundation.dart';
import 'package:task_app/data/data_result.dart';
import 'package:task_app/data/models/task.dart';

abstract class AbstractTaskViewModel extends ChangeNotifier{
  List<Task> _tasks;
  List<Task> get tasks => _tasks;

  set tasks(List<Task> value);

  Future<DataResult<void>> createTask(Task task);
  Future<DataResult<void>> editTask(Task task);
  Future<DataResult<List<Task>>> fetchAllTasks({String churchId, String type});
}

class TaskViewModel extends AbstractTaskViewModel{
  @override
  void set tasks(List<Task> value) {
    _tasks= value;
    notifyListeners();
  }

  @override
  Future<DataResult<void>> createTask(Task task) {
    // TODO: implement createTask
    return null;
  }

  @override
  Future<DataResult<void>> editTask(Task task) {
    // TODO: implement editTask
    return null;
  }

  @override
  Future<DataResult<List<Task>>> fetchAllTasks({String churchId, String type}) {
    // TODO: implement fetchAllTasks
    return null;
  }

}