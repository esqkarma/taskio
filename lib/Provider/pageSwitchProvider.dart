import 'package:flutter/material.dart';
class PageSwitchProvider extends ChangeNotifier{
  bool isUpcoming= true;

  void switchToCompleted(){
    if(isUpcoming) {
      isUpcoming = false;
      notifyListeners();
    }
  }
  void switchToUpcoming()
  {
    if(!isUpcoming)
      {
        isUpcoming=true;
        notifyListeners();
      }
  }
}