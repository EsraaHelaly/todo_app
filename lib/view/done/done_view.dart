import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/cubit/cubit.dart';
import 'package:todo_app/core/cubit/states.dart';
import 'package:todo_app/view/widgets/build_task_list_view.dart';

class DoneView extends StatelessWidget {
  const DoneView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          List<Map> doneTask = AppCubit.get(context).doneTasks;

          return BuildTaskListView(tasks: doneTask);
        });
  }
}
