import 'package:flutter/material.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';

class DialogExit extends StatelessWidget {
  final VoidCallback callBackCancel, callBackOk;

  DialogExit({@required this.callBackCancel, @required this.callBackOk});

  @override
  Widget build(BuildContext context) => Center(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
        Container(
            child: Stack(children: <Widget>[
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Material(
                  clipBehavior: Clip.antiAlias,
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(titleLogout, style: appBarTitleStyle),
                            SizedBox(height: 5.0),
                            Text(logoutMessage,
                                style: descriptionStyle)
                          ]))))
        ])),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton.extended(
                  elevation: 1.0,
                  backgroundColor: Colors.white,
                  //icon: const Icon(searchClearIcon, color: Colors.deepOrange, size: 18),
                  label: Text(cancelButton, style: btnCloseStyle),
                  onPressed: callBackCancel),
              FloatingActionButton.extended(
                  elevation: 1.0,
                  backgroundColor: Colors.white,
                  //icon: const Icon(logoutIcon, color: Colors.black, size: 18),
                  label: Text('     $okButton     ', style: btnOkStyle),
                  onPressed: callBackOk)
            ])
      ])));
}
