import 'package:flutter/material.dart';
import 'package:task_app/utils/app_colors.dart';

class AppStyles{
  static TextStyle h1Style = TextStyle(fontSize: 30,fontWeight: FontWeight.bold);
  static TextStyle h1StyleWhite = TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle h3StyleWhite = TextStyle(fontSize: 16,fontWeight: FontWeight.normal, color: Colors.white);
  static TextStyle taskSubTitle = TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: AppColors.textColor);
  static TextStyle taskItemTitle = TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: AppColors.textColor2);
  static TextStyle newTaskOptionsUnSelected = TextStyle(fontSize: 14,fontWeight: FontWeight.normal, color: AppColors.iconUnSelectedColor);
  static TextStyle newTaskOptionsSelected = TextStyle(fontSize: 14,fontWeight: FontWeight.w600);
  static TextStyle itemStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.w600);
  static TextStyle itemCountStyle = TextStyle(fontSize: 12,fontWeight: FontWeight.normal);
  static TextStyle newTaskAppBartStyle = TextStyle(fontSize: 18,fontWeight: FontWeight.w500, color: Colors.black);
}