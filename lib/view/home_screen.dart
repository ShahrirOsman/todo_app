import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/view/add_todo_screen.dart';
import 'package:todo_app/view/edit_todo_screen.dart';
import 'package:todo_app/view/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const id = '/home';
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'ToDo',
          style: kBoldTitle,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 25,
                  right: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Text(
                      'Hi!',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Here's Your ToDos.",
                      style: kBoldTitle,
                    ),
                  ],
                ),
              ),
              Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  dialogBackgroundColor: Colors.transparent,
                ),
                child: ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _getListItems(),
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final todo = todoController.todos.removeAt(oldIndex);
                    todoController.todos.insert(newIndex, todo);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: FloatingActionButton.extended(
            label: const Text(
              'Add Todo',
              style: kButtonTextStyle,
            ),
            icon: const Icon(
              Icons.add_circle_sharp,
              color: Colors.white,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            onPressed: () {
              Get.toNamed(AddTodoScreen.id);
            }),
      ),
    );
  }

  List<Widget> _getListItems() => todoController.todos
      .asMap()
      .map((i, item) => MapEntry(i, _buildCardList(i)))
      .values
      .toList();

  Widget _buildCardList(int index) {
    return Padding(
      key: ValueKey(todoController.todos[index]),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
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
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              todoController.todos.removeAt(index);
              Get.snackbar('Remove!', "Task was succesfully Delete",
                  backgroundColor: Colors.black,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: TaskCard(
            task: todoController.todos[index].text != ''
                ? todoController.todos[index].text!
                : '(No Title)',
            startDateTime: todoController.todos[index].startDateTime,
            endDateTime: todoController.todos[index].endDateTime,
            allDay: todoController.todos[index].allDay,
            onTap: () {
              if (!todoController.todos[index].done) {
                todoController.index.value = index;
                Get.toNamed(EditTodoScreen.id);
              }
            },
            done: todoController.todos[index].done,
          ),
        ),
      ),
    );
  }
}
