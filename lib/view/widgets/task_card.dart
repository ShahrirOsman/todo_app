import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    this.startDateTime,
    this.endDateTime,
    this.allDay = false,
    this.color,
    this.onTap,
    this.done = false,
    this.onCheckboxChanged,
    this.onDismissed,
    Key? key,
  }) : super(key: key);

  final String task;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final bool allDay;
  final bool done;
  final Color? color;
  final Function()? onTap;
  final Function(bool?)? onCheckboxChanged;
  final Function(DismissDirection)? onDismissed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: UniqueKey(),
          secondaryBackground: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: ShapeDecoration(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SizedBox(),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: ShapeDecoration(
              color: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  size: 20.sp,
                  color: Colors.white,
                ),
                SizedBox(),
              ],
            ),
          ),
          direction:
              done ? DismissDirection.endToStart : DismissDirection.horizontal,
          onDismissed: onDismissed,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Colors.greenAccent,
                    Colors.red
                  ], // red to yellow
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Card(
                key: key,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                elevation: 0,
                color: color ?? Colors.indigoAccent[100],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        task,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              startDateTime != null
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 13.sp,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          allDay
                                              ? dateFormat
                                                  .format(startDateTime!)
                                              : endDateTime != null
                                                  ? "${dateFormat.format(startDateTime!)} - ${dateFormat.format(endDateTime!)}"
                                                  : dateFormat
                                                      .format(startDateTime!),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: 1.h,
                              ),
                              startDateTime != null
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 13.sp,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          allDay
                                              ? "All-day"
                                              : endDateTime != null
                                                  ? "${timeFormat.format(startDateTime!)} - ${timeFormat.format(endDateTime!)}"
                                                  : timeFormat
                                                      .format(startDateTime!),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                            width: 8.w,
                            child: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.all(Colors.grey[800]),
                                value: done,
                                splashRadius: 15,
                                shape: const CircleBorder(),
                                onChanged: onCheckboxChanged,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
