import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/data/models/task.dart';
import 'package:task_app/screens/category_detail_screen.dart';
import 'package:task_app/screens/new_task_screen.dart';
import 'package:task_app/utils/app_colors.dart';
import 'package:task_app/utils/app_styles.dart';

import '../data/view_models/task_view_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage> {
  int _counter = 0;
  List<Lists> _list = [];
  List<Task> _tasks = [];
  List<Task> _workTasks = [];
  List<Task> _musicTasks = [];
  List<Task> _travelTasks = [];
  List<Task> _studyTasks = [];
  List<Task> _homeTasks = [];
  List<Task> _artTasks = [];
  List<Task> _shoppingTasks = [];

  AbstractTaskViewModel _taskViewModel;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _list = [
      Lists(name: "All", icon: "all", size: 23),
      Lists(name: "Work", icon: "work", size: 12),
      Lists(name: "Music", icon: "music", size: 6),
      Lists(name: "Travel", icon: "travel", size: 1),
      Lists(name: "Study", icon: "study", size: 23),
      Lists(name: "Home", icon: "home(1)", size: 23),
      Lists(name: "Art", icon: "art", size: 23),
      Lists(name: "Shopping", icon: "shop", size: 23),
    ];

    //handleTasks(Task.tasks);

    super.initState();
  }

  void handleTasks(List<Task> t) {
    _tasks = [];
    _workTasks = [];
    _musicTasks = [];
    _travelTasks = [];
    _studyTasks = [];
    _homeTasks = [];
    _artTasks = [];
    _shoppingTasks = [];
    t.forEach((task) {
      if (task.category == "Work") {
        _workTasks.add(task);
      } else if (task.category == "Music") {
        _musicTasks.add(task);
      } else if (task.category == "Travel") {
        _musicTasks.add(task);
      } else if (task.category == "Study") {
        _studyTasks.add(task);
      } else if (task.category == "Home") {
        _homeTasks.add(task);
      } else if (task.category == "Art") {
        _artTasks.add(task);
      } else if (task.category == "Shopping") {
        _shoppingTasks.add(task);
      }
    });

    _list.asMap().forEach((index,element) {
      if (element.name == "Work") {
        _list[index].size = _workTasks.length;
      } else if (element.name == "Music") {
        _list[index].size = _musicTasks.length;
      } else if (element.name == "Travel") {
        element.size = _travelTasks.length;
      } else if (element.name == "Study") {
        _list[index].size = _studyTasks.length;
      } else if (element.name == "Home") {
        _list[index].size = _homeTasks.length;
      } else if (element.name == "Art") {
        _list[index].size = _artTasks.length;
      } else if (element.name == "Shopping") {
        _list[index].size = _shoppingTasks.length;
      } else if (element.name == "All") {
        _list[index].size = t.length;
      }
    });

    _tasks = t;
    print("mmmm $_tasks");
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    _taskViewModel.listenForTasks().listen((event) {
      handleTasks(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    _taskViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 20,
                ),
                MenuIcon(),
                SizedBox(
                  height: 34,
                ),
                Text(
                  'Lists',
                  style: AppStyles.h1Style,
                ),
                SizedBox(
                  height: 40,
                ),
              ]),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 22.0,
                crossAxisSpacing: 22.0,
                childAspectRatio: 1,
                crossAxisCount: 2,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(CategoryDetailScreen.route(
                          _list[index],
                          getTasksForCategory(_list[index].name)));
                    },
                    child: new Container(
                      padding: EdgeInsets.all(20),
                      height: 166,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SvgPicture.asset(
                              "assets/images/${_list[index].icon}.svg"),
                          SizedBox(
                            height: 36,
                          ),
                          Text(
                            _list[index].name,
                            style: AppStyles.itemStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${_list[index].size} Tasks",
                            style: AppStyles.itemCountStyle,
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: _list.length,
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 45, right: 20),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(NewTaskScreen.route());
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Task> getTasksForCategory(String category) {
    if (category == "Work") {
      return _workTasks;
    } else if (category == "Music") {
      return _musicTasks;
    } else if (category == "Travel") {
      return _travelTasks;
    } else if (category == "Study") {
      return _studyTasks;
    } else if (category == "Home") {
      return _homeTasks;
    } else if (category == "Art") {
      return _artTasks;
    } else if (category == "Shopping") {
      return _shoppingTasks;
    }
    return _tasks;
  }
}

class MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 2.5,
            width: 23,
            decoration: BoxDecoration(color: AppColors.menuIcongColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 2.5,
            width: 23,
            decoration: BoxDecoration(color: AppColors.menuIcongColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 2.5,
            width: 12,
            decoration: BoxDecoration(color: AppColors.menuIcongColor),
          ),
        ],
      ),
    );
  }
}

class Lists {
  String icon;
  String name;
  int size;
  Lists({this.name, this.size, this.icon});
}
