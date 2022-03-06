import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/model/todo.dart';

class TodoController extends GetxController {
  var todos = List<Todo>.empty().obs;
  var index = 0.obs;
  var selectedStartDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().add(const Duration(hours: 1)).obs;
  var isAllDay = false.obs;
  var isAddEvent = false.obs;
  var strStartDate = ''.obs;
  var strEndDate = ''.obs;

  @override
  void onInit() {
    getTodos();
    super.onInit();
  }

  void resetState() {
    index.value = 0;
    selectedStartDate.value = DateTime.now();
    selectedEndDate.value = DateTime.now().add(const Duration(hours: 1));
    isAllDay.value = false;
    isAddEvent.value = false;
    strStartDate.value = '';
    strEndDate.value = '';
  }

  void getTodos() {
    List? storedTodos = GetStorage().read<List>('todo');
    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todo', todos.toList());
    });
  }

  void addTodo(
      {required String task,
      DateTime? startDateTime,
      DateTime? endDateTime,
      bool? allDay}) {
    print(allDay.toString());
    todos.add(
      Todo(
        text: task,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        allDay: allDay!,
      ),
    );
  }

  void editTodo(
      {required String task,
      DateTime? startDateTime,
      DateTime? endDateTime,
      bool? allDay}) {
    todos[index.value] = Todo(
      text: task,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      allDay: allDay!,
    );
  }

  void completeTodo(int index) {
    var todo = todos.removeAt(index);
    print("${todo.text} ${todo.done}");
    todo.done = true;
    todos.insert(todos.length, todo);
  }

  pickStartTime(BuildContext context) async {
    var pickedTime = await pickDateTime(
      context: context,
      initialDate: selectedStartDate.value,
      initialTime: TimeOfDay.fromDateTime(selectedStartDate.value),
    );
    if (pickedTime != null) {
      selectedStartDate.value = pickedTime;
      strStartDate.value = dateTimeFormat.format(selectedStartDate.value);
    }
  }

  pickEndTime(BuildContext context) async {
    var pickedTime = await pickDateTime(
      context: context,
      initialDate: selectedStartDate.value,
      initialTime: TimeOfDay.fromDateTime(selectedStartDate.value),
    );
    if (pickedTime != null) {
      selectedEndDate.value = pickedTime;
      strEndDate.value = dateTimeFormat.format(selectedEndDate.value);
    }
  }

  Future addEvent({
    required String task,
    // required DateTime startDate,
    // required DateTime endDate,
    // bool allDay = false,
  }) async {
    await Add2Calendar.addEvent2Cal(
      buildEvent(
        task: task,
        startDate: selectedStartDate.value,
        endDate: selectedEndDate.value,
        allDay: isAllDay.value,
      ),
    );
  }

  Event buildEvent({
    required String task,
    required DateTime startDate,
    required DateTime endDate,
    bool allDay = false,
    String description = '',
    String location = '',
    Recurrence? recurrence,
  }) {
    return Event(
      title: task,
      description: description,
      startDate: startDate,
      endDate: endDate,
      allDay: false,
      recurrence: recurrence,
    );
  }

  Future<DateTime?> pickDateTime({
    required BuildContext context,
    required DateTime initialDate,
    required TimeOfDay initialTime,
  }) async {
    DateTime? dateTimePicked;
    TimeOfDay? timePicked;

    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
    ).whenComplete(() async {
      timePicked = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
    });

    if ((datePicked != null) && (timePicked != null)) {
      dateTimePicked = joinDateTime(datePicked, timePicked!);
    }
    return dateTimePicked;
  }

  bool isFirstLaunch() {
    bool? isFirstLaunch = GetStorage().read<bool>('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      todos.add(
        Todo(
          text: 'Your First Task',
          startDateTime: DateTime.now(),
        ),
      );
      GetStorage().write('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }
}
