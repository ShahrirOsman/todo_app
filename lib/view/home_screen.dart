import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/view/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
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
            TaskCard(task: 'dasdasd', date: DateTime.now()),
            TaskCard(
              task: 'dasdasd',
              date: DateTime.now(),
              color: Colors.amberAccent,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            'Add Todo',
            style: TextStyle(color: Colors.white),
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
          onPressed: () {}),
    );
  }
}
