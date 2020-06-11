import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/data/models/task.dart';

import '../data_result.dart';

class TaskApi extends AbstractTaskApi{
  final Firestore database = Firestore.instance;



  @override
  Future<DataResult<void>> createTask(Task task) async {
    DataResult<void> result = DataResult(error: false);
    final DocumentReference newDocument = database.collection("tasks")
       .document();
    task.id = newDocument.documentID;
    result.error = false;
    await newDocument.setData(task.toJson())
        .catchError((error){
      result.error = true;
    });

    if(result.error == false){

    }else{
      result.errorMessage = "Could not create a group, try again!";
    }

    return result;
  }

  @override
  Future<DataResult<void>> editTask(Task task) async{
    DataResult<void> result = DataResult();
    final DocumentReference newDocument = database.collection("tasks")
        .document(task.id);

    result.error = false;
    await newDocument.updateData({
      "title":task.title,
      "note":task.note,
      "category":task.category,
      "time":task.time != null ? Timestamp.fromDate(task.time) :Timestamp.fromDate(DateTime.now()),
    })
        .catchError((error){
      print("error ${error.toString()}");
      result.error= true;
    });

    if(result.error == false){

    }else{
      result.errorMessage = "Could not Edit the group, try again!";
    }

    return result;
  }

  @override
  Future<DataResult<List<Task>>> fetchAllTasks({String churchId, String type}) async{
    DataResult<List<Task>> result = DataResult();
    result.error = false;

    final response = await database
        .collection("tasks")
        .getDocuments()
        .catchError((error) {
      result.error = true;
      result.errorMessage = error.toString();
    });

    if (result.error == false) {
      List<Task> tasks = [];
      response.documents.forEach((element) {
        tasks.add(Task.fromJson(element.data));
      });
      result.data = tasks;
      print("pppp ${response.documents.length}");
    }

    return result;
  }

}

abstract class AbstractTaskApi{

  Future<DataResult<void>> createTask(Task task);
  Future<DataResult<void>> editTask(Task task);
  Future<DataResult<List<Task>>> fetchAllTasks({String churchId, String type});

}