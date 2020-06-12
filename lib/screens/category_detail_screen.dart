import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/screens/home_screennn.dart';
import 'package:task_app/screens/new_task_screen.dart';
import 'package:task_app/utils/app_colors.dart';
import 'package:task_app/utils/app_styles.dart';
import 'package:task_app/utils/utils.dart';

import '../utils/utils.dart';

class CategoryDetailScreen extends StatefulWidget {
  final Lists lists;
  final List<Task> tasks;

  const CategoryDetailScreen({Key key, this.lists, this.tasks})
      : super(key: key);
  static Route<dynamic> route(Lists lists, List<Task> tasks) {
    return MaterialPageRoute(
        builder: (_) => CategoryDetailScreen(
              lists: lists,
              tasks: tasks,
            ),
        settings: RouteSettings(name: CategoryDetailScreen().toStringShort()));
  }

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<List<Task>> tasks = [];
  List<Task> _pastTasks = [];
  List<Task> _newTasks = [];
  var today = DateTime.now();

  void handleTasks(List<Task> tasks1) {
    _pastTasks = tasks1
        .where((test) =>
            test.time.day < today.day && test.time.month <= today.month)
        .toList();
    _newTasks = tasks1
        .where((test) =>
            test.time.day >= today.day && test.time.month >= today.month)
        .toList();

    for (var i = 0; i < _newTasks.length; i++) {
      Task notif = _newTasks[i];
      //print("ooopp ${!notif.time.difference(DateTime.now()).isNegative} -- ${notif.time.toUtc()}");

      if (i == 0) {
        tasks.add([notif]);
      } else {
        Task prevNotif = _newTasks[i - 1];
        if (prevNotif.time.day != notif.time.day ||
            prevNotif.time.month != notif.time.month) {
          tasks.add([notif]);
        } else {
          tasks.last.add(notif);
        }
      }
    }

    if (_pastTasks.isNotEmpty) {
      tasks.insert(0, _pastTasks);
    }

    print("ttggtt $tasks");
  }

  @override
  void initState() {
    print("cccc ${widget.tasks}");
    handleTasks(widget.tasks);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 45, right: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(NewTaskScreen.route());
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.primaryColor,
              height: MediaQuery.of(context).size.height - 300,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BackButton(
                      color: AppColors.white,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 44,
                      width: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.white, shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        "assets/images/${widget.lists.icon}.svg",
                        height: 20,
                        width: 26,
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.lists.name,
                        style: AppStyles.h1StyleWhite,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "${widget.lists.size} Tasks",
                        style: AppStyles.h3StyleWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: MediaQuery.of(context).size.height / 1.5,
              child: widget.tasks.isNotEmpty
                  ? CustomScrollView(
                      slivers: <Widget>[
                        for (var c in tasks)
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 30),
                                child: Text(
                                  getDatTitle(c.first),
                                  style: AppStyles.taskSubTitle,
                                ),
                              ),
                              for (var i in c)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(top: 20),
                                  height: 50,
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            i.title,
                                            style: AppStyles.taskItemTitle,
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(AppUtils.getDate(i.time))
                                        ],
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/images/unchecked.svg")
                                    ],
                                  ),
                                )
                            ]),
                          ),
                      ],
                    )
                  : Center(
                      child: Text("Empty"),
                    ),
            ),
          )
        ],
      ),
    );
  }

  String getDate(Task i) {
    return "${AppUtils.addLeadingZeroIfNeeded(i.time.hour)}:"
        "${AppUtils.addLeadingZeroIfNeeded(i.time.minute)} ${AppUtils.getMonthStringFull(i.time.month)} ${AppUtils.addLeadingZeroIfNeeded(i.time.day)}";
  }

  String getDatTitle(Task task) {
    if (task.time.day == DateTime.now().day) {
      return "Today";
    } else if (task.time.difference(DateTime.now()).isNegative) {
      return "Late";
    } else {
      return "in ${DateTimeFormat.relative(DateTime.now(), relativeTo: task.time)}";
    }
  }
}
