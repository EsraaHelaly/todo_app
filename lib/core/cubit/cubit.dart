import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/cubit/states.dart';
import 'package:todo_app/view/archived/archived_view.dart';
import 'package:todo_app/view/done/done_view.dart';
import 'package:todo_app/view/tasks/new_task_view.dart';

class AppCubit extends Cubit<States> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> views = [
    NewTaskView(),
    DoneView(),
    ArchivedView(),
  ];
  List<String> titles = [
    'NewTask',
    'Done',
    'Archived',
  ];
  Database database;

  List<Map> tasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  bool isBottomSheet = false;
  IconData icon = Icons.edit;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  void changeBottomSheetState(bool isBottomSheet, IconData icon) {
    this.isBottomSheet = isBottomSheet;
    this.icon = icon;

    emit(ChangeBottomSheetState());
  }

  onCreateDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date text, time text,status text)')
            .then((value) => print('table created'));
      },
      onOpen: (database) {
        print('database openned');

        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  insertIntoDatabase(
      {@required String title,
      @required String time,
      @required String date}) async {
    await database
        .transaction((txn) => txn.rawInsert(
            'insert into tasks(title,time,date,status)values("$title","$time","$date","new")'))
        .then((value) {
      emit(InsertDatabaseState());

      getDataFromDatabase(database);

      print('$value inserted ');
    });
  }

  getDataFromDatabase(database) async {
    emit(LoadingState());

    tasks = [];
    doneTasks = [];
    archivedTasks = [];
    return await database.rawQuery('select * from tasks').then((value) {
      for (var task in value) {
        if (task['status'] == 'new')
          tasks.add(task);
        else if (task['status'] == 'done')
          doneTasks.add(task);
        else
          archivedTasks.add(task);
      }

      emit(GetDatabaseState());
    });
  }

  void updateData({@required String status, @required int id}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(UpdateDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void deleteData({@required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteDatabaseState());
      getDataFromDatabase(database);
    });
  }
}
