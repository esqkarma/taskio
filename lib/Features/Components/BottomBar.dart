import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Features/Components/ColorPalate.dart';
import 'package:taskio/Features/Components/CustomSnackBar.dart';
import 'package:taskio/Features/Components/Custom_TextField.dart';
import 'package:taskio/Provider/pageSwitchProvider.dart';

import '../../Provider/TaskProvider.dart';

class BottomBar extends StatefulWidget {
   const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
 final TextEditingController captionController = TextEditingController();
 final TextEditingController timeController = TextEditingController();
 FocusNode focusNode1 = FocusNode();
 FocusNode focusNode2 = FocusNode();



 @override
   void disposeController() {
     captionController.dispose();
     timeController.dispose();
     super.dispose();
   }
 @override
 void dispose() {
   focusNode1.dispose();
   focusNode2.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final taskProvider = Provider.of<TaskProvider>(context);
    final pageSwitchProvider = Provider.of<PageSwitchProvider>(context);

//This function is used to pass the user input from this class to list
    void passingFunction()
    {
      if (captionController.text.isNotEmpty && timeController.text.isNotEmpty) {
        if(taskProvider.box.isEmpty)
          {
            taskProvider.addTask(captionController.text.toString(), timeController.text.toString(),isOngoing: true);
          }
        else
          {
            taskProvider.addTask(captionController.text.toString(), timeController.text.toString(),isOngoing: false);
          }
         FocusScope.of(context).unfocus();
        captionController.clear();
        timeController.clear();


      } else
        if(captionController.text.isNotEmpty){
        showCustomSnackBar(context, 'Please add time');
      }
        else
          {
            showCustomSnackBar(context, 'Please add a task');
          }
    }




    return AnimatedSwitcher(

      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: Offset(0,1), // from right
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: pageSwitchProvider.isUpcoming
          ? Row(
                  key: ValueKey(true),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
          Container(
            height: width * 0.15,
            width: width * 0.80,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Color(0xFFC5C5ED),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTextfield(
                    focusNode: focusNode1,
                    customController: captionController,
                    hintText: 'type here',
                    height: height,
                    width: width,
                    textInputType: TextInputType.text,
                    maxLength:200,
                    function: () {
                      FocusScope.of(context).requestFocus(focusNode2);
                    },
                  ),
                ),
                VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black12,
                ),
                SizedBox(
                  height: height,
                  width: width * 0.80 * 0.30,
                  child: CustomTextfield(
                    focusNode: focusNode2,
                    customController: timeController,
                    hintText: 'minutes',
                    textInputType: TextInputType.number,
                    maxLength: 5,
                    function: passingFunction,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: passingFunction,
            child: Container(
              height: width * 0.15,
              width: width * 0.15,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: bottomBarButtonColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(Icons.arrow_upward,
                  color: Colors.white, size: 35),
            ),
          ),
                  ],
                )
          : SizedBox.shrink(key: ValueKey(false)),
    );


  }

}
