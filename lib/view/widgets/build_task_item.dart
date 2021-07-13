import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/cubit/cubit.dart';
import 'package:todo_app/core/cubit/states.dart';

class BuildTaskItem extends StatelessWidget {
  final Map tasks;
  BuildTaskItem({
    Key key,
    this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Dismissible(
          key: Key(tasks['id'].toString()),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  child: Text(
                    '${tasks["time"]}',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                  radius: 35.0,
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tasks["title"]}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${tasks["date"]}',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50.0),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateData(status: 'done', id: tasks['id']);
                  },
                  icon: Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 10.0),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateData(status: 'archive', id: tasks['id']);
                  },
                  icon: Icon(
                    Icons.archive_outlined,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          onDismissed: (direction) {
           return AppCubit.get(context).deleteData(id: tasks['id']);
          }),
    );
  }
}
