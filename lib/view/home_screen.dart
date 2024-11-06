import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolist/Model/task_model.dart';
import 'package:todolist/Bloc/task_bloc.dart';
import 'package:todolist/Bloc/task_event.dart';
import 'package:todolist/Bloc/task_state.dart';
import 'package:todolist/view/taskform_Screen.dart';
import 'package:todolist/common/contansts/common_color.dart';
import 'package:todolist/common/contansts/common_widgets.dart';

import '../Provider/taskprovider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              TaskBloc(taskProvider: context.read<TaskProvider>())
                ..add(LoadTasks()),
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TaskLoaded) {
                print(
                    "Tasks loaded: ${state.tasks.length}"); // Log the number of tasks
                return Scaffold(
                    backgroundColor: AppColors.bgColor,
                    body: SafeArea(
                        child: Stack(children: [
                      Positioned(
                        left: 0,
                        top: 20,
                        child: SvgPicture.asset(
                          'assets/images/circle_design.svg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonWidgets.autoText(
                                    'Welcome Onboard!', Colors.black,
                                    fontSize: 30),
                                SizedBox(height: 20),
                                Text(
                                  'Add What you want to do later on..',
                                  style:
                                      TextStyle(color: AppColors.primaryColor),
                                ),
                                Expanded(
                                    child: state.tasks.isEmpty
                                        ? Center(
                                            child: Text(
                                                'No tasks available. Add some tasks!'))
                                        : ListView.builder(
                                            itemCount: state.tasks.length,
                                            itemBuilder: (context, index) {
                                              final task = state.tasks[index];
                                              return ListTile(
                                                title: Text(
                                                  task.title,
                                                  style: TextStyle(
                                                    decoration: task.isCompleted
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : null,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                    task.description ?? ''),
                                                leading: Checkbox(
                                                  value: task.isCompleted,
                                                  onChanged: (bool? value) {
                                                    context.read<TaskBloc>().add(
                                                        ToggleTaskCompletion(
                                                            task));
                                                  },
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () =>
                                                          showTaskFormScreen(
                                                              context,
                                                              task: task),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () => context
                                                          .read<TaskBloc>()
                                                          .add(
                                                              DeleteTask(task)),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ))
                              ]))
                    ])));
              } else if (state is TaskError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return Center(child: Text('Something went wrong.'));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showTaskFormScreen(context),
      ),
    );
  }

  void showTaskFormScreen(BuildContext context, {Task? task}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task),
      ),
    );
  }
}
