import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../../services/theme_services.dart';
import 'notification_screen.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();

  DateTime selectdate = DateTime.now();
  String _startdate = DateFormat('hh:mm a').format(DateTime.now());
  String _endtdate = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedremind = 5;
  List<int> remindlist = [5, 10, 15, 20];
  String? _slectedRepeat = "None";
  List<String> repeatlist = ["none", "Daily", "Weekly", "Monthly"];
  int selectedcolor = 0;

  _addTasksToDb() async {
    try {
      int value = await _taskController.addtask(
          task: Task(
            title: _titlecontroller.text,
            note: _notecontroller.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(selectdate),
            startTime: _startdate,
            endTime: _endtdate,
            remind: _selectedremind,
            repeat: _slectedRepeat,
            color: selectedcolor,
          ));
      print("$value");
    }catch(e){
      print("ERROR");
    }
  }

  _validateData() {
    if (_titlecontroller.text.isNotEmpty && _notecontroller.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else if (_titlecontroller.text.isEmpty || _notecontroller.text.isEmpty) {
      Get.snackbar("required", "All Fields are required",
          backgroundColor: Colors.white,
          colorText: pinkClr,
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print("############## SOMETHING WENT WRONGE ##################");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            size: 24,
            color: primaryClr,
          ),
          onPressed: () {
            // ThemeServices().switchTheme();
            Get.to(const HomePage());
          },
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 19,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: headingstyle,
              ),
              InputField(
                  title: "title",
                  hint: "Enter the title",
                  controller: _titlecontroller,
                  // widget: widget,
                  obscureText: false,
                  prefix: null,
                  suffix: null),
              InputField(
                  title: "Note",
                  hint: "Enter the Note",
                  controller: _notecontroller,
                  //widget: widget,
                  obscureText: false,
                  prefix: null,
                  suffix: null),
              InputField(
                  title: "Date",
                  hint: DateFormat.yMMMMd().format(DateTime.now()),
                  controller: null,
                  widget: IconButton(
                      onPressed: () => _getDateFromUser(),
                      color: Colors.grey,
                      icon: Icon(Icons.calendar_today_outlined)),
                  obscureText: false,
                  prefix: null,
                  suffix: null),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                        title: "Start Date",
                        controller: null,
                        hint: _startdate,
                        widget: IconButton(
                            onPressed: () => getTimeFromUser(isStartTime: true),
                            color: Colors.grey,
                            icon: Icon(Icons.access_time_filled_rounded)),
                        obscureText: false,
                        prefix: null,
                        suffix: null),
                  ),
                  Expanded(
                    child: InputField(
                        title: "End Date",
                        hint: _endtdate,
                        controller: null,
                        widget: IconButton(
                            onPressed: () =>
                                getTimeFromUser(isStartTime: false),
                            color: Colors.grey,
                            icon: Icon(Icons.access_time_filled_rounded)),
                        obscureText: false,
                        prefix: null,
                        suffix: null),
                  ),
                ],
              ),
              InputField(
                  title: "Remind List",
                  hint: "$_selectedremind miinutes early",
                  controller: null,
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    items: remindlist
                        .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    "$value",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                        .toList(),
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    elevation: 4,
                    iconSize: 32,
                    style: subTitlestyle,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedremind = int.parse(value!);
                      });
                    },
                  ),
                  obscureText: false,
                  prefix: null,
                  suffix: null),
              InputField(
                  title: "Repeat",
                  hint: _slectedRepeat,
                  controller: null,
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    items: repeatlist
                        .map<DropdownMenuItem<String>>(
                            (String? value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    "$value",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                        .toList(),
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    elevation: 4,
                    iconSize: 32,
                    style: subTitlestyle,
                    onChanged: (String? value) {
                      setState(() {
                        _slectedRepeat = value!;
                      });
                    },
                  ),
                  obscureText: false,
                  prefix: null,
                  suffix: null),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Color"),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: List<Widget>.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedcolor = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      child: selectedcolor == index
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                          : null,
                                      backgroundColor: index == 0
                                          ? Colors.red
                                          : index == 1
                                              ? Colors.blueGrey
                                              : Colors.orange,
                                    ),
                                  ),
                                )),
                      )
                    ],
                  ),
                  MyButton(
                    label: "Create Task",
                    onTap: () {
                      _validateData();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _peckedDate = await showDatePicker(
        context: context,
        initialDate: selectdate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if (_peckedDate != null) {
      setState(() {
        selectdate = _peckedDate;
      });
    } else
      print("It is null or something is wrong");
  }

  getTimeFromUser({bool? isStartTime}) async {
    TimeOfDay? _peckedTime =
    await showTimePicker(context: context, initialTime: isStartTime! ?
    TimeOfDay.fromDateTime(DateTime.now()) :
    TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15))));

    String _formateddate = _peckedTime!.format(context);
    if (isStartTime) {
      setState(() {
        _startdate = _formateddate;
      });
    }
    else if(!isStartTime){
      setState(() {
        _endtdate=_formateddate;
      });
    }
    else
      {
        print("time is canceled or someting went wrong");
      }
  }
}
