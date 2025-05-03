import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/CustomSnackBar.dart';
import 'package:taskio/Provider/TaskProvider.dart';
import '../../Provider/TimeProvider.dart';
import '../../Provider/animationProvider.dart';
import '../../Provider/soundProvider.dart';

class TaskComplitionPopUP extends StatelessWidget {
  const TaskComplitionPopUP({super.key,});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final timerProvider = Provider.of<TimeProvider>(context);
    final soundProvider = Provider.of<SoundProvider>(context);
    final confettiProvider = Provider.of<ConfettiProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;


    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: width * 0.50,
            width: width * 0.8,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Did you complete the task',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                  fontFamily: 'Cagody'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {

                          int? index = taskProvider.onGoingTaskIndex();
                          taskProvider.setTaskCompletedStatus(index, false);


                          taskProvider.task[index].isOngoing = false;
                          showCustomSnackBar(context, 'complete the task');
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });

                        },




                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                        final index = taskProvider.onGoingTaskIndex();
                             taskProvider.setTaskCompletedStatus(index,true);
                            Navigator.pop(context);
                            soundProvider.taskCompletedsound();
                            confettiProvider.playConfetti();
                            timerProvider.stopTimer();
                            FocusScope.of(context).unfocus();



                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
