import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/view/widgets/custom_text_field.dart';

class EditTodo extends StatelessWidget {
  const EditTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Edit Todo',
          style: kBoldTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              CustomTextField(
                label: 'Task',
                onChanged: (value) {},
              ),
              CustomTextField(
                label: 'Time',
                onChanged: (value) {},
                suffixIcon: IconButton(
                  splashRadius: 20,
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


