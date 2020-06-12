import 'dart:async';

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
  Future<DataResult<List<Task>>> fetchAllTasks() async{
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

  Stream<List<Task>> listenForTasks()  {
    var streamTransformer =
    StreamTransformer<QuerySnapshot, List<Task>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink sink) {
        List<Task> tasks = [];
        data.documents.forEach((element) {
          tasks.add(Task.fromJson(element.data));
        });
        sink.add(tasks);
      },
      handleError: (error, stacktrace, sink) {
        print("ppppp release error");
        sink.addError('Something went wrong: $error');
      },
      handleDone: (sink) {
        sink.close();
      },
    );
    final response =  database
        .collection("tasks").snapshots();


    return response.transform(streamTransformer);
  }


}

abstract class AbstractTaskApi{

  Future<DataResult<void>> createTask(Task task);
  Future<DataResult<void>> editTask(Task task);
  Future<DataResult<List<Task>>> fetchAllTasks();
  Stream<List<Task>> listenForTasks();

}