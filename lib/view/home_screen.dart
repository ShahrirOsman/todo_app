import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Hi,'),
          const Text("Here's Your Today"),
          Card(
            elevation: 0,
            color: Colors.amberAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('TASKKKK'),
                    Row(
                      children: const [
                        Icon(Icons.calendar_month_outlined),
                        Text('12 March 2022'),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.access_time),
                        Text('7:30 PM'),
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
