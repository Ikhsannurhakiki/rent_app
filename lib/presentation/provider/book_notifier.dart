import 'package:flutter/material.dart';

class BookNotifier extends ChangeNotifier{
  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  void setRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  void resetRange() {
    _startDate = null;
    _endDate = null;
    notifyListeners();
  }
}