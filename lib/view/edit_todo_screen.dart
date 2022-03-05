import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/view/widgets/bottom_button.dart';
import 'package:todo_app/view/widgets/custom_switch_button.dart';
import 'package:todo_app/view/widgets/custom_text_field.dart';
import 'package:todo_app/view/widgets/input_date_time.dart';

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({Key? key}) : super(key: key);
  static const id = '/editTodo';

  final TodoController todoController = Get.find<TodoController>();
  final TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    editController.text =
        todoController.todos[todoController.index.value].text!;
    todoController.isAllDay.value =
        todoController.todos[todoController.index.value].allDay;
    if (todoController.todos[todoController.index.value].startDateTime !=
        null) {
      todoController.isAllDay.value
          ? todoController.strStartDate.value = dateFormat.format(
              todoController.todos[todoController.index.value].startDateTime!)
          : todoController.strStartDate.value = dateTimeFormat.format(
              todoController.todos[todoController.index.value].startDateTime!);
    }
    if (todoController.todos[todoController.index.value].endDateTime != null) {
      todoController.isAllDay.value
          ? todoController.strEndDate.value = dateFormat.format(
              todoController.todos[todoController.index.value].endDateTime!)
          : todoController.strEndDate.value = dateTimeFormat.format(
              todoController.todos[todoController.index.value].endDateTime!);
    }

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Edit Todo',
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Task',
                        controller: editController,
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: BottomButton(
                          title: 'Complete Task',
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            var todo = todoController
                                .todos[todoController.index.value];
                            todo.done = true;
                            todoController.todos[todoController.index.value] =
                                todo;
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                title: 'Save Task',
                onPressed: () {
                  todoController.editTodo(
                    task: editController.text,
                    startDateTime: todoController.strStartDate.value != ''
                        ? todoController.selectedStartDate.value
                        : null,
                    endDateTime: todoController.strEndDate.value != ''
                        ? todoController.selectedEndDate.value
                        : null,
                    allDay: todoController.isAllDay.value,
                  );
                  todoController.resetState();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
