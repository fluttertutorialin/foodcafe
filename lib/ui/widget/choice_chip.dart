import 'package:flutter/material.dart';

class SingleChoiceHolder extends StatefulWidget {
  final List<String> choiceList;
  final String initialChoice;
  final dynamic _onSave;
  SingleChoiceHolder(this.choiceList, this.initialChoice, this._onSave);

  @override
  _SingleChoiceHolderState createState() => _SingleChoiceHolderState();
}

class _SingleChoiceHolderState extends State<SingleChoiceHolder> {
  String choice;
  dynamic onSave;
  @override
  void initState() {
    super.initState();
    setState(() {
      choice = widget.initialChoice;
      onSave = widget._onSave;
    });
  }

  @override
  Widget build(BuildContext context) {
    final choiceList = widget.choiceList;
    return Row(
        children: choiceList.map((cc) {
      return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
              elevation: 8,
              label: Text(cc.toUpperCase()),
              selected: choice == cc,
              onSelected: (checked) {
                setState(() {
                  choice = checked ? cc : choice;
                  onSave(cc);
                });
              }));
    }).toList());
  }
}
