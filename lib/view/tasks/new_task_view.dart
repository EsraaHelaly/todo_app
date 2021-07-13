import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/cubit/cubit.dart';
import 'package:todo_app/core/cubit/states.dart';
import 'package:todo_app/view/widgets/build_task_list_view.dart';

class NewTaskView extends StatelessWidget {
  const NewTaskView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          List<Map> newTask = AppCubit.get(context).tasks;

          return AppCubit.get(context).tasks.length > 0
              ? BuildTaskListView(tasks: newTask)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/add.svg',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Please Add Some Tasks',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}
