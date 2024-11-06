import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Bloc/task_event.dart';
import 'package:todolist/Provider/taskprovider.dart';
import 'package:todolist/view/home_screen.dart';
import 'package:todolist/view/splach_screen.dart';
import 'package:todolist/Bloc/task_bloc.dart';
import 'package:todolist/Model/task_model.dart';

import 'bloc/task_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: BlocProvider(
        create: (context) => TaskBloc(taskProvider: context.read<TaskProvider>()),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(taskProvider: TaskProvider()),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
