
import 'package:flutter/material.dart';

class PrograssHud extends ChangeNotifier{

  bool isLoading=false;

 void changeLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
}