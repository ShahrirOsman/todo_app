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
    todoController.fetchTodoByIndex();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:  Text(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
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
                          todoController.onAllDayChanged();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: BottomButton(
                          title: 'Complete Task',
                          backgroundColor: Colors.indigoAccent[100],
                          foregroundColor: Colors.black,
                          onPressed: () {
                            todoController
                                .completeTodo(todoController.index.value);
                            Get.back();
                          },
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
