import 'package:flutter/material.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';

class PauseMenuOrderOffTimer extends StatefulWidget {
  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<PauseMenuOrderOffTimer> {
  int pos = 0;
  List<String> timeSlotList = ["Day End", "2 Hours", "6 Hours", "Custom"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              setState(() {
                pos = index;
              });
            },
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                child: Row(children: [
                  pos == index
                      ? Icon(radioSelectIcon, color: radioSelectColor, size: 18)
                      : Icon(radioUnSelectIcon,
                          color: radioUnSelectColor, size: 18),
                  SizedBox(width: 10),
                  Text(timeSlotList[index],
                      style: bottomSheetPauseMenuOrderOnOffTimerLabelStyle)
                ])));
      },
      itemCount: timeSlotList.length,
    );
  }
}
