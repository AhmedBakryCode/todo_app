import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import '../../controllers/task_controller.dart';
import '../../services/notification_services.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selecteddate = DateTime.now();
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Get.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round_outlined,
            size: 24,
            color: primaryClr,
          ),
          onPressed: () {
            setState(() {
              ThemeServices().switchTheme();
              // notifyHelper.displayNotification(
              //     title: "Theme Changed", body: "vddvn");
              // notifyHelper.scduleNotification();
            });
            // Get.to(const NotificationScreen(paylod: "Title|discription|10:16"));
          },
        ),
        actions:  [
          IconButton(
            icon: Icon(
              Icons.cleaning_services_rounded,
              size: 24,
              color: primaryClr,
            ),
            onPressed: (){_taskController.deleteAllTask();
            notifyHelper.cancelAllNotification();
            },
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 19,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _addtaskbar(),
            SizedBox(
              height: 6,
            ),
            _adddatebar(),
            SizedBox(
              height: 6,
            ),
            _showtsks(),
          ],
        ),
      ),
    );
  }

  _adddatebar() {
    return Container(
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        initialSelectedDate: DateTime.now(),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        onDateChange: (newDate) {
          setState(() {
            _selecteddate = newDate;
          });
        },
      ),
    );
  }

  _showtsks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _notaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onrefresh,
            child: ListView.builder(
                itemCount: _taskController.taskList.length,
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  var task = _taskController.taskList[index];
                  if (task.date == DateFormat.yMd().format(_selecteddate) ||
                      task.repeat == 'Daily' ||
                      (task.repeat == "Weekly" &&
                          _selecteddate
                                      .difference(
                                          DateFormat.yMd().parse(task.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == "Monthly" &&
                          DateFormat.yMd().parse(task.date!).day ==
                              _selecteddate.day)) {
                    var hour = task.startTime.toString().split(":")[0];
                    var minute = task.startTime.toString().split(":")[1];

                    var date = DateFormat.jm().parse(task.startTime!);
                    var mytime = DateFormat("HH:mm").format(date);

                    notifyHelper.scheduledNotification(
                      int.parse(mytime.toString().split(":")[0]),
                      int.parse(mytime.toString().split(":")[1]),
                      task,
                    );
                    return AnimationConfiguration.staggeredList(
                        duration: Duration(milliseconds: 2000),
                        position: index,
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () => showbuttomsheet(context, task),
                              child: TaskTile(task),
                            ),
                          ),
                        ));
                  } else
                    return Container();
                }),
          );
        }
      }),
    );

    //     GestureDetector(
    //       onTap:(){
    //         showbuttomsheet(context, Task(title: "Title 1",
    //           note: "Note somthing ",
    //           isCompleted: 0,
    //           startTime: "9:50",
    //           endTime: "12:00",
    //           color: 1,));
    //       } ,
    //       child: TaskTile(Task(
    //   title: "Title 1",
    //   note: "Note somthing ",
    //   isCompleted: 0,
    //   startTime: "9:50",
    //   endTime: "12:00",
    //   color: 1,
    // )),
    //     ));
    //
    // else {
    //   return Container();
    // }
  }

  _addtaskbar() {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subheadingstyle,
              ),
              Text(
                "Today",
                style: subheadingstyle,
              )
            ],
          ),
          MyButton(
              label: "Add Task",
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  _notaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 20000),
          child: RefreshIndicator(
            onRefresh: _onrefresh,
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 100,
                        ),
                  SvgPicture.asset(
                    "images/task.svg",
                    color: primaryClr.withOpacity(0.6),
                    semanticsLabel: "Task",
                    height: 90,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      "you do not have any tasks yet!\n"
                      "Addnew tasks to make your days productive",
                      style: subTitlestyle,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  showbuttomsheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.38),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 20,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              task.isCompleted == 1
                  ? Container()
                  : buildBottomSheet(
                      label: "Task Completed",
                      onTap: () {
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: primaryClr),
              Divider(
                color: Get.isDarkMode ? Colors.grey : darkHeaderClr,
              ),
              buildBottomSheet(
                  label: "Cancel",
                  onTap: () {
                    Get.back();
                  },
                  clr: primaryClr),
              buildBottomSheet(
                  label: "Delete Task",
                  onTap: () {
                    notifyHelper.cancelNotification(task);

                    _taskController.deleteTask(task: task);
                    Get.back();
                  },
                  clr: primaryClr),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    ));
  }

  buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titlestyle
                : titlestyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _onrefresh() async {
    _taskController.getTasks();
  }
}
