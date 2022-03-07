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
    todo.done = true;
    todos.insert(todos.length, todo);
    Get.snackbar('Well Done!', "You have completed a task",
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
    Get.snackbar('Remove!', "Task was succesfully Delete",
        backgroundColor: Colors.black54,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void reorderTodo(int oldIndex, int newIndex) {
    final todo = todos.removeAt(oldIndex);
    todos.insert(newIndex, todo);
  }

  void fetchTodoByIndex() {
    isAllDay.value = todos[index.value].allDay;
    if (todos[index.value].startDateTime != null) {
      isAllDay.value
          ? strStartDate.value =
              dateFormat.format(todos[index.value].startDateTime!)
          : strStartDate.value =
              dateTimeFormat.format(todos[index.value].startDateTime!);
    }
    if (todos[index.value].endDateTime != null) {
      isAllDay.value
          ? strEndDate.value =
              dateFormat.format(todos[index.value].endDateTime!)
          : strEndDate.value =
              dateTimeFormat.format(todos[index.value].endDateTime!);
    }
  }

  void onAllDayChanged() {
    isAllDay.value
        ? strStartDate.value = dateFormat.format(selectedStartDate.value)
        : strStartDate.value = dateTimeFormat.format(selectedStartDate.value);
    isAllDay.value
        ? strEndDate.value = dateFormat.format(selectedEndDate.value)
        : strEndDate.value = dateTimeFormat.format(selectedEndDate.value);
  }

  void onAddEventChanged() {
    isAllDay.value
        ? strStartDate.value = dateFormat.format(selectedStartDate.value)
        : strStartDate.value = dateTimeFormat.format(selectedStartDate.value);
    isAllDay.value
        ? strEndDate.value = dateFormat.format(selectedEndDate.value)
        : strEndDate.value = dateTimeFormat.format(selectedEndDate.value);
  }

  pickStartTime(BuildContext context) async {
    var pickedTime = await pickDateTime(
      context: context,
      initialDate: selectedStartDate.value,
      initialTime: TimeOfDay.fromDateTime(selectedStartDate.value),
    );
    if (pickedTime != null) {
      selectedStartDate.value = pickedTime;
      strStartDate.value = isAllDay.value
          ? dateFormat.format(selectedStartDate.value)
          : dateTimeFormat.format(selectedStartDate.value);
    }
  }

  pickEndTime(BuildContext context) async {
    var pickedTime = await pickDateTime(
      context: context,
      initialDate: selectedStartDate.value.add(const Duration(hours: 1)),
      initialTime: TimeOfDay.fromDateTime(
        selectedStartDate.value.add(const Duration(hours: 1)),
      ),
    );
    if (pickedTime != null) {
      selectedEndDate.value = pickedTime;
      strEndDate.value = isAllDay.value
          ? dateFormat.format(selectedEndDate.value)
          : dateTimeFormat.format(selectedEndDate.value);
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
      allDay: allDay,
      recurrence: recurrence,
    );
  }

  Future<DateTime?> pickDateTime({
    required BuildContext context,
    required DateTime initialDate,
    required TimeOfDay initialTime,
    bool allDay = false,
  }) async {
    DateTime? dateTimePicked;
    TimeOfDay? timePicked;

    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    ).whenComplete(() async {
      allDay
          ? timePicked = await showTimePicker(
              context: context,
              initialTime: initialTime,
            )
          : timePicked = null;
    });

    if ((datePicked != null) && (timePicked != null)) {
      dateTimePicked = joinDateTime(datePicked, timePicked!);
    }
    if ((datePicked != null) && (timePicked == null)) {
      dateTimePicked = joinDateTime(datePicked, initialTime);
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
