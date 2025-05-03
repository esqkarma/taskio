import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/TaskProvider.dart';
import '../../Provider/TimeProvider.dart';
import '../../Provider/soundProvider.dart';
import 'ColorPalate.dart';


class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final soundProvider = Provider.of<SoundProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: taskProvider.task.length,
        itemBuilder: (context, index) {
          final data = taskProvider.task[index];

          if (!data.isCompleted) {
            return SizedBox.shrink();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onLongPress: ()async{
                 await soundProvider.taskDeletedsound();
                 taskProvider.removeTask(index);
                },
                child:Container(
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
                              overflow: TextOverflow.ellipsis,
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
