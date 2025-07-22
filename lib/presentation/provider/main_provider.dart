import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier{
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  void setTabIndex (int index){
    _tabIndex = index;
    notifyListeners();
  }
}