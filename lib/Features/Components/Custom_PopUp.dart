import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/Custom_TextField.dart';
import 'package:taskio/Provider/TaskProvider.dart';

class PopUpScreen extends StatelessWidget {
  final int index;
  const PopUpScreen({required this.index,super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController captionController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          child: Container(
            height: height * 0.40,
            width: width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Update Task',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: CustomTextfield(
                      customController: captionController,
                      hintText: "caption",
                      height: null,
                      width: null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: CustomTextfield(
                      customController: timeController,
                      hintText: "set time",
                      height: null,
                      width: null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          captionController.clear();
                          timeController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: width * 0.20 / 2,
                          height: width * 0.37 / 4,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(245, 198, 198, 1.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(Icons.close),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          taskProvider.updateTask(index, captionController.text.toString(), timeController.text.toString());

                          captionController.clear();
                          timeController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: width * 0.18 / 2,
                          height: width * 0.37 / 4,
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
            ),
          ),
        ),
      ),
    );
  }
}
