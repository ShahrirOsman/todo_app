
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';

class InputDateTime extends StatelessWidget {
  const InputDateTime({
    required this.label,
    required this.value,
    this.onCalendarPress,
    this.onRemovePress,
    Key? key,
  }) : super(key: key);
  final String label;
  final String value;
  final Function()? onCalendarPress;
  final Function()? onRemovePress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: kLabelTextStyle),
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Text(value),
                  value != ''
                      ? IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            Icons.highlight_off,
                            color: Colors.black,
                          ),
                          onPressed: onRemovePress,
                        )
                      : const SizedBox(),
                ],
              )),
              IconButton(
                splashRadius: 25,
                icon: const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
                onPressed: onCalendarPress,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
