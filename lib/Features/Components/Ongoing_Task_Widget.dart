import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Provider/TimeProvider.dart';

import '../../Provider/TaskProvider.dart';

class OnGoingTaskSection extends StatelessWidget {
   OnGoingTaskSection({super.key});
    int? inputTime;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final timerProvider = Provider.of<TimeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double progress = (timerProvider.totalSeconds > 0)
        ? timerProvider.remainingSeconds / timerProvider.totalSeconds
        : 1;

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
              onTap:(){
                int index = taskProvider.task.indexWhere((task)=>task.isOngoing);
                taskProvider.setTaskCompletedStatus(index);
                timerProvider.stopTimer();
              } ,
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

                            if(data.isOngoing) {
                              inputTime=int.tryParse(data.timer);
                              return Text(data.task,style: const TextStyle(fontSize: 26,),);
                            }
                            else
                              {
                                return SizedBox.shrink();
                              }

                            }))),
              ),
            ),
            GestureDetector(
                 onTap: (){
                   if(timerProvider.isRunning)
                     {
                           timerProvider.pauseTimer();


                     }
                   else if(timerProvider.isPaused && !timerProvider.isRunning)
                     {
                       timerProvider.resumeTimer();

                     }

                     else
                       {
                         timerProvider.startTimer(inputTime!);
                       }

                 },

              onLongPress: (){
                           timerProvider.stopTimer();


              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: width * 0.35,
                  width: width*0.18,

                  decoration: BoxDecoration(
                      color: timeAnimationColor,
                    borderRadius: BorderRadius.circular(15)
                  ),

                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: width*0.35* progress,
                      decoration: BoxDecoration(
                        color: Color.lerp(Color(0xFF1B1B85), Color(0xFF4B4BB4), progress),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(timerProvider.remainingSeconds.toString())),

                    ),
                  ),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
