import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:task_app/data/view_models/task_view_model.dart';
import 'package:task_app/screens/home_screennn.dart';
import 'package:task_app/utils/app_colors.dart';
import 'package:task_app/utils/app_styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ), providers: <SingleChildWidget>[
      ChangeNotifierProvider<AbstractTaskViewModel>(create: (_) => TaskViewModel()),
    ],
    );
  }
}

