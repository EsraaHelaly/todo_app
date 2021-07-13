import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/cubit/cubit.dart';
import 'package:todo_app/core/cubit/states.dart';

import 'widgets/custom_text_form_field.dart';

class HomeView extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..onCreateDatabase(),
      child: BlocConsumer<AppCubit, States>(listener: (context, States state) {
        if (state is InsertDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (BuildContext context, States state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex])),
          body: state is! LoadingState
              ? cubit.views[cubit.currentIndex]
              : Center(child: CircularProgressIndicator()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheet) {
                if (formKey.currentState.validate()) {
                  cubit.insertIntoDatabase(
                    title: titleController.text,
                    time: timeController.text,
                    date: dateController.text,
                  );
                }
              } else {
                scaffoldKey.currentState
                    .showBottomSheet(
                      (context) => Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                controller: titleController,
                                onTap: () {
                                  print('title added');
                                },
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'empty field';
                                  else
                                    return null;
                                },
                                text: 'task title',
                                textType: TextInputType.text,
                                prefix: Icon(Icons.title),
                              ),
                              SizedBox(height: 15),
                              CustomTextFormField(
                                controller: timeController,
                                onTap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) => timeController.text =
                                          value.format(context));
                                  print('time added');
                                },
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'empty field';
                                  else
                                    return null;
                                },
                                text: 'task time',
                                textType: TextInputType.text,
                                prefix: Icon(Icons.timer),
                              ),
                              SizedBox(height: 15),
                              CustomTextFormField(
                                controller: dateController,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse("2021-08-27"),
                                  ).then(
                                    (value) => dateController.text =
                                        DateFormat.yMMMd().format(value),
                                  );
                                  print('date added');
                                },
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'empty field';
                                  else
                                    return null;
                                },
                                text: 'task date',
                                textType: TextInputType.datetime,
                                prefix: Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(false, Icons.edit);
                });
                cubit.changeBottomSheetState(true, Icons.add);
              }
            },
            tooltip: 'Increment',
            child: Icon(cubit.icon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            elevation: 0.15,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done),
                label: "Done",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: "Archived",
              ),
            ],
          ),
        );
      }),
    );
  }
}
