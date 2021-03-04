import 'package:flutter/material.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/font.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';

class TextFieldSearch extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final VoidCallback callBackClear, callBackPrefix, callBackSearch;
  final RxBool isSuffixIconVisible;
  final isPrefixIconVisible;
  final String hintText;

  TextFieldSearch(
      {@required this.isSuffixIconVisible,
      @required this.textEditingController,
      @required this.onChanged,
      this.callBackClear,
      this.isPrefixIconVisible = false,
      this.callBackSearch,
      this.callBackPrefix,
      this.hintText = hintSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: searchHeight,
        margin: EdgeInsets.all(10),
        child: TextField(
            controller: textEditingController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            cursorColor: appBarTitleColor,
            style: TextStyle(fontSize: 15, fontFamily: regularFont),
            decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                prefixIcon: isPrefixIconVisible
                    ? IconButton(
                        icon: Icon(backIcon, size: 20, color: textFieldBackIconColor),
                        onPressed: callBackPrefix)
                    : null,
                suffixIcon: isSuffixIconVisible.value
                    ? IconButton(
                        icon:
                            Icon(searchClearIcon, size: 18, color: textFieldSuffixPrefixIconColor),
                        onPressed: callBackClear)
                    : IconButton(
                        icon: Icon(searchIcon, size: 20, color: textFieldSuffixPrefixIconColor),
                        onPressed: callBackSearch),
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10.0)),
                    borderSide: BorderSide(color: searchBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10.0)),
                    borderSide: BorderSide(color: searchBorderColor)),
                filled: true,
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: regularFont,
                    color: hintSearchColor,
                    textBaseline: TextBaseline.alphabetic),
                hintText: hintText,
                fillColor: searchBackgroundColor)));
  }
}
