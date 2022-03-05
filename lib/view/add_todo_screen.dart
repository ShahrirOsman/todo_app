import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/view/widgets/bottom_button.dart';
import 'package:todo_app/view/widgets/custom_switch_button.dart';
import 'package:todo_app/view/widgets/custom_text_field.dart';
import 'package:todo_app/view/widgets/input_date_time.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);
  static const id = '/addTodo';
  final TodoController todoController = Get.find<TodoController>();
  final TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'New Todo',
          style: kBoldTitle,
        ),
        leading: IconButton(
          onPressed: () {
            todoController.resetState();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'My New Task',
                        controller: taskController,
                      ),
                      InputDateTime(
                        label: 'Start Date',
                        value: todoController.strStartDate.value,
                        onCalendarPress: () async {
                          await todoController.pickStartTime(context);
                        },
                        onRemovePress: () {
                          todoController.strStartDate.value = '';
                          todoController.selectedStartDate.value =
                              DateTime.now();
                        },
                      ),
                      InputDateTime(
                        label: 'End Date',
                        value: todoController.strEndDate.value,
                        onCalendarPress: () async {
                          await todoController.pickEndTime(context);
                        },
                        onRemovePress: () {
                          todoController.strEndDate.value = '';
                          todoController.selectedEndDate.value =
                              DateTime.now().add(const Duration(hours: 1));
                        },
                      ),
                      CustomSwitchButton(
                        label: 'All-day',
                        value: todoController.isAllDay.value,
                        onChanged: (value) {
                          todoController.isAllDay.value = value;

                          if (todoController.isAllDay.value) {
                            todoController.selectedStartDate.value;
                          }

                          todoController.isAllDay.value
                              ? todoController.strStartDate.value =
                                  dateFormat.format(
                                      todoController.selectedStartDate.value)
                              : todoController.strStartDate.value =
                                  dateTimeFormat.format(
                                      todoController.selectedStartDate.value);
                          todoController.isAllDay.value
                              ? todoController.strEndDate.value = dateFormat
                                  .format(todoController.selectedEndDate.value)
                              : todoController.strEndDate.value = dateTimeFormat
                                  .format(todoController.selectedEndDate.value);
                        },
                      ),
                      CustomSwitchButton(
                        label: 'Add Event To Calendar',
                        value: todoController.isAddEvent.value,
                        onChanged: (value) {
                          todoController.isAddEvent.value = value;

                          todoController.isAllDay.value
                              ? todoController.strStartDate.value =
                                  dateFormat.format(
                                      todoController.selectedStartDate.value)
                              : todoController.strStartDate.value =
                                  dateTimeFormat.format(
                                      todoController.selectedStartDate.value);
                          todoController.isAllDay.value
                              ? todoController.strEndDate.value = dateFormat
                                  .format(todoController.selectedEndDate.value)
                              : todoController.strEndDate.value = dateTimeFormat
                                  .format(todoController.selectedEndDate.value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                title: 'Save Task',
                onPressed: () async {
                  todoController.addTodo(
                    task: taskController.text,
                    startDateTime: todoController.strStartDate.value != ''
                        ? todoController.selectedStartDate.value
                        : null,
                    endDateTime: todoController.strEndDate.value != ''
                        ? todoController.selectedEndDate.value
                        : null,
                    allDay: todoController.isAllDay.value,
                  );
                  if (todoController.isAddEvent.value) {
                    await todoController
                        .addEvent(task: taskController.text)
                        .then((value) {
                      todoController.resetState();
                      Get.back();
                    });
                  } else {
                    todoController.resetState();
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
