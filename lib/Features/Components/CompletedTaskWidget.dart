import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/TaskProvider.dart';
import 'ColorPalate.dart';


class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
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
                onLongPress: (){
                  taskProvider.removeTask(index);
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
