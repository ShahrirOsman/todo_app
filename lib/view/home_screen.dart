import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/view/add_todo_screen.dart';
import 'package:todo_app/view/edit_todo_screen.dart';
import 'package:todo_app/view/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const id = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoController todoController = Get.put(TodoController());
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();

  @override
  void initState() {
    super.initState();
    var isFirst = todoController.isFirstLaunch();
    if (isFirst) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context)!
            .startShowCase([_one, _two, _three, _four]),
      );
    }
  }

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
      floatingActionButton: Showcase(
        key: _one,
        description: 'Click here to create task',
        radius: const BorderRadius.all(
          const Radius.circular(20),
        ),
        overlayPadding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 3.w),
        child: Padding(
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
      ),
    );
  }

  List<Widget> _getListItems() => todoController.todos
      .asMap()
      .map((i, item) => MapEntry(i, _buildCardList(i)))
      .values
      .toList();

  Widget _buildCardList(int index) {
    return index == 0
        ? Showcase(
            key: _two,
            description: 'Tap to manage task. \nLong press to sort task ',
            child: Showcase(
              key: _three,
              description: 'Swipe to the left to delete task',
              child: Showcase(
                key: _four,
                description: 'Swipe to the right to complete task',
                child: TaskCard(
                  key: ValueKey(todoController.todos[index]),
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
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      todoController.todos.removeAt(index);
                      Get.snackbar('Remove!', "Task was succesfully Delete",
                          backgroundColor: Colors.grey,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                    if (direction == DismissDirection.startToEnd) {
                      print('ltr');
                      todoController.completeTodo(index);
                      Get.snackbar('Well Done!', "You have completed a task",
                          backgroundColor: Colors.grey,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                ),
              ),
            ),
          )
        : TaskCard(
            key: ValueKey(todoController.todos[index]),
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
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                todoController.todos.removeAt(index);
                Get.snackbar('Remove!', "Task was succesfully Delete",
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);
              }
              if (direction == DismissDirection.startToEnd) {
                print('ltr');
                todoController.completeTodo(index);
                Get.snackbar('Well Done!', "You have completed a task",
                    backgroundColor: Colors.grey,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
          );
  }
}
