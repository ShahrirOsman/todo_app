import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/view/add_todo_screen.dart';
import 'package:todo_app/view/edit_todo_screen.dart';
import 'package:todo_app/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          unselectedWidgetColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        initialRoute: HomeScreen.id,
        getPages: [
          GetPage(
            name: HomeScreen.id,
            page: () => HomeScreen(),
          ),
          GetPage(
            name: AddTodoScreen.id,
            page: () => AddTodoScreen(),
          ),
          GetPage(
            name: EditTodoScreen.id,
            page: () => EditTodoScreen(),
          ),
        ],
      );
    });
  }
}
