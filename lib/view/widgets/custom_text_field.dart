import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.hintText,
    this.readOnly = false,
    Key? key,
  }) : super(key: key);
  final String label;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: kLabelTextStyle),
          TextField(
            readOnly: readOnly,
            style: kBoldTitle,
            maxLines: null,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
