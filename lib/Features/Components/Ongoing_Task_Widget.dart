import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Features/Components/CustomSnackBar.dart';
import 'package:taskio/Features/Components/taskComplitionPopUP.dart';
import 'package:taskio/Provider/TimeProvider.dart';
import 'package:taskio/Provider/soundProvider.dart';

import '../../Provider/TaskProvider.dart';
import '../../Provider/animationProvider.dart';
import 'DayDisplay.dart';

class OnGoingTaskSection extends StatefulWidget {
  OnGoingTaskSection({super.key});

  @override
  State<OnGoingTaskSection> createState() => _OnGoingTaskSectionState();
}

class _OnGoingTaskSectionState extends State<OnGoingTaskSection> {
  int? inputTime;

  final ConfettiController confettiController = ConfettiController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final timerProvider = Provider.of<TimeProvider>(context);
    final soundProvider = Provider.of<SoundProvider>(context);
    final confettiProvider =
        Provider.of<ConfettiProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double progress = (timerProvider.totalSeconds > 0)
        ? timerProvider.remainingSeconds / timerProvider.totalSeconds
        : 0;

    return SizedBox(
      height: width * 0.40,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                //assigning the index of task which isOngoing is true
                final index = taskProvider.onGoingTaskIndex();

                //Checking whether the list is empty or not
                if (taskProvider.box.isEmpty) {
                  showCustomSnackBar(context, 'add a task');
                }
                //checking whether there is onGoingTask=true task available
                else if (index < 0) {
                  showCustomSnackBar(context, 'start a task');
                } else if (timerProvider.remainingSeconds < timerProvider.totalSeconds / 2 && !timerProvider.isRunning ) {
                  soundProvider.taskCompletedsound();
                  confettiProvider.playConfetti();
                  taskProvider.setTaskCompletedStatus(index, true);
                  timerProvider.stopTimer();
                } else {
                  showCustomSnackBar(context, 'try to complete the task');
                }
              },
              onDoubleTap: () {
                //Double tap on onGoingTaskCard makes that task's onGoing criteria flase
                // and droped down to UpcomingTask section,Timer also stops
                final index = taskProvider.onGoingTaskIndex();
                taskProvider.setTaskOnGoingFalse(index);
                timerProvider.stopTimer();
              },
              child: Container(
                height: width * 0.35,
                width: width * 0.70,
                decoration: BoxDecoration(
                    color: onGoingTaskCardColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    //checking whether the List is empty and showing accordingly
                    child: taskProvider.isThereonGoingTask()
                        ? ListView.builder(
                            itemCount: taskProvider.box.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final data = taskProvider.box.getAt(index);

                              if (data.isOngoing) {
                                inputTime = int.tryParse(data.timer);
                                return Text(
                                  data.task,
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Cagody',
                                      wordSpacing: 1),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            })
                        : Center(
                            child: Text(
                              'Add Task ',
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cagody',
                                  color: Colors.black26),
                            ),
                          )),
              )),
          GestureDetector(
            onTap: () {
              if(!taskProvider.isThereonGoingTask()){
                showCustomSnackBar(context, 'Add a Task');
              }
              //⏸️Condition To pause Timer
              if (timerProvider.isRunning) {
                soundProvider.pauseTimerSound();
                timerProvider.pauseTimer();
              } else
              //⏯️Condition to Resume Timer
              if (timerProvider.isPaused && !timerProvider.isRunning) {
                soundProvider.resumeTimerSound();
                timerProvider.resumeTimer(
                  onLastTenSeconds: soundProvider.lastFiveSecondSound,
                  timeOverSound: soundProvider.timeOverSound,
                  taskComplition: () {
                    // Show the popup dialog
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) => TaskComplitionPopUP(),
                      );
                    });
                  },
                );
              }

              //▶️Condition To Start Timer
              else {
                //checking whether there is any ongoing task available, If yes, the time will be start
                bool isAnyTaskOngoing =
                    taskProvider.task.any((task) => task.isOngoing);
                if (isAnyTaskOngoing) {
                  soundProvider.startTimerSound();
                  timerProvider.startTimer(
                    inputTime,
                    onLastTenSeconds: soundProvider.lastFiveSecondSound,
                    timeOverSound: soundProvider.timeOverSound,
                    taskComplition: () {
                      // Show the popup dialog
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (context) => TaskComplitionPopUP(),
                        );
                      });
                    },
                  );
                } else {
                  return;
                }
              }
            },
            onLongPress: () {
              soundProvider.stopTimerSound();
              timerProvider.stopTimer();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  height: width * 0.35,
                  width: width * 0.18,
                  decoration: BoxDecoration(
                      color: timeAnimationColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: timerProvider.isRunning
                      ? Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 1000),
                                height: width * 0.35 * progress,
                                decoration: BoxDecoration(
                                  color: Color.lerp(Color(0xFF1B1B85),
                                      Color(0xFF4B4BB4), progress),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              formatTime(timerProvider.remainingSeconds),
                              style:  TextStyle(color: timerProvider.remainingSeconds<timerProvider.totalSeconds/2? scaffoldTopDarkColor:onGoingTaskCardColor,fontSize: 18),
                            ))
                          ],
                        )
                      : Icon(
                          timerProvider.isPaused
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 60,
                        )),
            ),
          )
        ],
      ),
    );
  }
}
