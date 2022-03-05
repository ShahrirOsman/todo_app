import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
      {Key? key,
      required this.title,
      this.onPressed,
      this.backgroundColor,
      this.foregroundColor})
      : super(key: key);

  final String title;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        title,
        style: TextStyle(color: foregroundColor ?? Colors.white),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.black,
        minimumSize: Size(100.w, 5.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
