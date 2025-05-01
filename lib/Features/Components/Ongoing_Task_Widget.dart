import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Provider/TimeProvider.dart';
import 'package:taskio/Provider/soundProvider.dart';

import '../../Provider/TaskProvider.dart';
import '../../Provider/animationProvider.dart';

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
    double width = MediaQuery.of(context).size.width;
    double progress = (timerProvider.totalSeconds > 0)
        ? timerProvider.remainingSeconds / timerProvider.totalSeconds
        : 0;
    final soundProvider = Provider.of<SoundProvider>(context);
    final confettiProvider =
        Provider.of<ConfettiProvider>(context, listen: false);

    return Container(
      height: width * 0.40,
      width: width,
      color: scaffoldBackgroundColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //assigning the index of task which isOngoing is true
                int? index = taskProvider.task.indexWhere((task) => task.isOngoing);

                if (timerProvider.remainingSeconds == 0) {


                  if (index >= 0) {
                    soundProvider.taskCompletedsound();
                    confettiProvider.playConfetti();
                    taskProvider.setTaskCompletedStatus(index);
                    timerProvider.stopTimer();
                  }
                }
                else if(index<0){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please add a task'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('bro complete the fucking Task'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: Container(
                height: width * 0.35,
                width: width * 0.70,
                decoration: BoxDecoration(
                    color: onGoingTaskCardColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: ListView.builder(
                            itemCount: taskProvider.task.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final data = taskProvider.task[index];

                              if (data.isOngoing) {
                                inputTime = int.tryParse(data.timer);
                                return Text(
                                  data.task,
                                  style: const TextStyle(
                                    fontSize: 26,
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }))),
              ),
            ),
            GestureDetector(
              onTap: () {

                //⏸️Condition To pause Timer
                if (timerProvider.isRunning) {
                  soundProvider.pauseTimerSound();
                  timerProvider.pauseTimer();
                } else


                  //⏯️Condition to Resume Timer
                  if (timerProvider.isPaused && !timerProvider.isRunning) {
                  soundProvider.resumeTimerSound();

                  timerProvider.resumeTimer(
                      onLastTenSeconds: soundProvider.lastFiveSecondSound,timeOver: soundProvider.timeOverSound);
                }

                  //▶️Condition To Start Timer
                  else {
                  //checking whether there is any ongoing task available, If yes, the time will be start
                  bool isAnyTaskOngoing =
                      taskProvider.task.any((task) => task.isOngoing);
                  if (isAnyTaskOngoing) {
                    soundProvider.startTimerSound();
                    timerProvider.startTimer(inputTime,
                        onLastTenSeconds: soundProvider.lastFiveSecondSound,
                        timeOver: soundProvider.timeOverSound);
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
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 1000),
                              height: width * 0.35 * progress,
                              decoration: BoxDecoration(
                                color: Color.lerp(Color(0xFF1B1B85),
                                    Color(0xFF4B4BB4), progress),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Text(timerProvider.remainingSeconds
                                      .toString())),
                            ),
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
      ),
    );
  }
}
