import 'package:flutter/material.dart';

import 'build_task_item.dart';

class BuildTaskListView extends StatelessWidget {
  final List<Map> tasks;
  const BuildTaskListView({
    Key key,
    this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => BuildTaskItem(tasks: tasks[index]),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
        itemCount: tasks.length);
  }
}
