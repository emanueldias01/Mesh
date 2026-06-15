
import 'package:flutter/material.dart';

class MeetingLobbyPageViewmodel extends ChangeNotifier{
  final meetingCodeController = TextEditingController();
  final callerIdController = TextEditingController();

  bool isLoading = false;

  String errorMessage = "";


  Future<bool> joinMeeting() async {
    isLoading = true;
    notifyListeners();

    //simula verificacao se sala existe para entrar
    await Future.delayed(const Duration(seconds: 1));

    if(callerIdController.text.isEmpty) {
      errorMessage = "Your caller ID is empyt";
      isLoading = false;
      notifyListeners();
      return false;
    }

    if(meetingCodeController.text == "12345") {
      isLoading = false;
      errorMessage = "";
      notifyListeners();
        
      return true;
    }else {
      isLoading = false;
      meetingCodeController.text = "";
      notifyListeners();
      errorMessage = "No rooms found";
      return false;
    }

  }

  Future<bool> createMeeting() async {
    isLoading = true;
    notifyListeners();

    //simula criação de sala 
    await Future.delayed(const Duration(seconds: 1));

    isLoading = false;
    notifyListeners();
    return true;
  }
}