import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Features/Components/CustomSnackBar.dart';
import 'package:taskio/Model/Todo_Model.dart';
import 'package:taskio/Provider/TaskProvider.dart';
import '../../Provider/TimeProvider.dart';
import '../../Provider/animationProvider.dart';
import '../../Provider/soundProvider.dart';
import 'CustomSnackBar.dart';

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
              color: onGoingTaskCardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          showCustomSnackBar(context, 'complete the task');
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });

                        },
                      child:  Container(
                        width: width * 0.20 / 2,
                        height: width * 0.35 / 4,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 198, 198, 1.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.close),
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
                      child: Container(
                      width: width * 0.18 / 2,
                      height: width * 0.35 / 4,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(165, 214, 167, 1.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.check),
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
