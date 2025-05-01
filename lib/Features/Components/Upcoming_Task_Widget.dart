import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Features/Components/Custom_PopUp.dart';
import 'package:taskio/Provider/TaskProvider.dart';
import 'package:taskio/Provider/TimeProvider.dart';
import 'package:taskio/Provider/soundProvider.dart';

class UpcomingTaskWidget extends StatefulWidget {
  const UpcomingTaskWidget({super.key});

  @override
  State<UpcomingTaskWidget> createState() => _UpcomingTaskWidgetState();
}

class _UpcomingTaskWidgetState extends State<UpcomingTaskWidget> {
  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimeProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final soundProvider = Provider.of<SoundProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: taskProvider.task.length,
        itemBuilder: (context, index) {
          final data = taskProvider.task[index];

          if (data.isOngoing ) {
            return SizedBox.shrink();
          }
            else if(data.isCompleted)
              {
                return SizedBox.shrink();
              }

          else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onHorizontalDragEnd: (detail) {
                  if (detail.primaryVelocity != null) {
                    if (detail.primaryVelocity! > 0) {
                      soundProvider.taskDeletedsound();
                      taskProvider.removeTask(index);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Removed Task'),
                        duration: Duration(milliseconds: 500),
                      ));
                    } else if (detail.primaryVelocity! < 0) {
                      showDialog(
                          context: context,
                          builder: (context) => PopUpScreen(
                                index: index,
                              ));
                    }
                  }
                },
                onTap: () {
                  bool ongoingStatus = taskProvider.setTaskOnGoingStatus(index);
                  timeProvider.remainingSeconds = int.tryParse(data.timer) ?? 0;

                  if (ongoingStatus) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       backgroundColor: scaffoldBackgroundColor,
                        duration: Duration(milliseconds: 300),
                        content: Text('Ongoing task already exists!')));
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     duration: Duration(milliseconds: 300),
                    //     content: Text('Task added')));
                  }
                },
                child: Container(
                  width: width,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                      color: onGoingTaskCardColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    width: width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.task,
                            style: TextStyle(overflow: TextOverflow.fade),
                          ),
                          Text('${data.timer} min',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.fade,
                                  color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}