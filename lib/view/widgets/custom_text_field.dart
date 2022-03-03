import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    this.onChanged,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);
  final String label;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          TextField(
            style: kBoldTitle,
            maxLines: null,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
