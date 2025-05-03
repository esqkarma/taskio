import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Features/Components/CustomSnackBar.dart';
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

                     showCustomSnackBar(context, 'task removed');
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

                  // making the task's ongoing = true and storing the output in ongoingStatus variable
                  bool ongoingStatus = taskProvider.setTaskOnGoingStatus(index);
                  timeProvider.remainingSeconds = int.tryParse(data.timer) ?? 0;

                  if (ongoingStatus) {
                    showCustomSnackBar(context, 'complete ongoing task');
                  } else {
                    soundProvider.taskAddedSound();
                  showCustomSnackBar(context, 'task added');
                  }
                },
                onLongPress: (){},
                child: Container(
                width: width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: onGoingTaskCardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.task,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        fontFamily: 'Cagody',
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${data.timer} min',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ),
            );
          }
        });
  }
}