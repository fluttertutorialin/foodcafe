import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'text_field_search.dart';
import '../../resource/routes.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';

class DialogSearch extends StatefulWidget {
  final VoidCallback callSearchClear;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final RxBool isVisibleSearchClearIcon;

  const DialogSearch(
      {Key key, @required this.isVisibleSearchClearIcon,
      @required this.callSearchClear,
      @required this.textEditingController,
      @required this.onChanged}) : super(key: key);

  @override
  createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch>
    with SingleTickerProviderStateMixin {
  Tween<Offset> _positionTween;
  Animation<Offset> _positionAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 750));

    //_positionTween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0)); //BOTTOM ANIMATION
    _positionTween = Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero); //TOP ANIMATION

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      child: SlideTransition(
          position: _positionAnimation,
          child: SizedBox(
              width: double.infinity,
              child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFieldSearch(
                            isSuffixIconVisible:
                                widget.isVisibleSearchClearIcon,
                            textEditingController: widget.textEditingController,
                            callBackClear: widget.callSearchClear,
                            onChanged: widget.onChanged),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                  //splashColor: appBarTitleColor,
                                  //highlightColor: appBarTitleColor,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50)),
                                  child:
                                      Text(closeButton, style: btnCloseStyle),
                                  onPressed: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    controller.reverse();
                                    await Future.delayed(
                                        const Duration(milliseconds: 750));
                                    Get.back();
                                  }),
                              const SizedBox(width: 10),
                              FlatButton(
                                  //splashColor: appBarTitleColor,
                                  //highlightColor: appBarTitleColor,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(allFindButton, style: btnFindStyle),
                                  onPressed: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    controller.reverse();
                                    await Future.delayed(const Duration(milliseconds: 750));
                                    Get.back();
                                    Get.toNamed(allFindRoute);
                                  }),
                              const SizedBox(width: 15)
                            ])
                      ])))));
}
