import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

import '../data/models/task.dart';
import '../data/models/task.dart';
import '../data/view_models/task_view_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_styles.dart';
import '../utils/utils.dart';

class NewTaskScreen extends StatefulWidget {
  final Task task;

  const NewTaskScreen({Key key, this.task}) : super(key: key);
  static Route<dynamic> route({Task task}) {
    return MaterialPageRoute(
        builder: (_) => NewTaskScreen(
              task: task,
            ),
        settings: RouteSettings(name: NewTaskScreen().toStringShort()));
  }

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  DateTime _time;
  String _title;
  String _note;
  String _category;
  TextEditingController _titleController;
  TextEditingController _noteController;
  var _loading = false;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  AbstractTaskViewModel _taskViewModel;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task == null ? "":widget.task.title);
    _noteController = TextEditingController(text: widget.task == null ? "":widget.task.note);
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _taskViewModel = Provider.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.newTaskBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "New Task",
          style: AppStyles.newTaskAppBartStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("What are you planning?"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _titleController,
                        maxLines: 5,
                        decoration: InputDecoration(

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(DateTime.now().year),
                            maxTime: DateTime(2030),
                            onChanged: (date) {}, onConfirm: (date) {
                          print('confirm $date');
                          setState(() {
                            _time = date;
                          });
                        }, locale: LocaleType.en);
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.notifications_none,
                              color: _time == null
                                  ? AppColors.iconUnSelectedColor
                                  : AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _time == null?"Select time": AppUtils.getDate2(_time),
                              style: _time == null
                                  ? AppStyles.newTaskOptionsUnSelected
                                  : AppStyles.newTaskOptionsSelected,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset("assets/images/note.svg", color: _note == null
                            ? AppColors.iconUnSelectedColor
                            : AppColors.primaryColor,),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _noteController,
                            decoration: InputDecoration(
                              hintText: "Add Note",
                              hintStyle: AppStyles.newTaskOptionsUnSelected,
                              border: InputBorder.none
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        SelectDialog.showModal<String>(
                          context,
                          label: "Simple Example",
                          selectedValue: _category,
                          items: ["Work","Music","Travel","Study","Home","Art","Shopping"],
                          onChange: (String selected) {
                            setState(() {
                              _category = selected;
                            });
                          },
                        );
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset("assets/images/tag.svg",color: _note == null
                                ? AppColors.iconUnSelectedColor
                                : AppColors.primaryColor),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Category", style: AppStyles.newTaskOptionsUnSelected,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () async{
                  var error = SnackBar(content: Text('You missed one or two fields'), backgroundColor: Colors.redAccent,);
                  var error2 = SnackBar(content: Text('Could not create a new task, try again'), backgroundColor: Colors.redAccent,);
                  var success = SnackBar(content: Text('Successfully Created a task'), backgroundColor: Colors.greenAccent,);
                  if(_time == null || _noteController.text.isEmpty||_titleController.text.isEmpty){
                    _scaffoldKey.currentState.showSnackBar(error);
                  }else{
                    setState(() {
                      _loading = true;
                    });
                    var result = await _taskViewModel.createTask(Task(
                        title: _titleController.text.trim(),
                        note: _noteController.text.trim(),
                        time: _time,
                        category: "Art"
                    ));
                    if(result.error == true){
                      _scaffoldKey.currentState..showSnackBar(error2);
                    }else{
                      _scaffoldKey.currentState.showSnackBar(success);
                      Future.delayed(Duration(seconds: 1)).then((value) => Navigator.of(context).popUntil((route) => route.isFirst));
                    }
                  }

                },
                child: _loading == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),): Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
