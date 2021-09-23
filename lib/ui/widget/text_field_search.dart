import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resource/colors.dart';
import '../../resource/font.dart';
import '../../resource/images.dart';
import '../../resource/value.dart';

class TextFieldSearch extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final VoidCallback callBackClear, callBackPrefix, callBackSearch;
  final RxBool isSuffixIconVisible;
  final bool isPrefixIconVisible;
  final String hintText;

  const TextFieldSearch(
      {Key key, @required this.isSuffixIconVisible,
      @required this.textEditingController,
      @required this.onChanged,
      this.callBackClear,
      this.isPrefixIconVisible = false,
      this.callBackSearch,
      this.callBackPrefix,
      this.hintText = hintSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: searchHeight,
        margin: const EdgeInsets.all(10),
        child: TextField(
            controller: textEditingController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            cursorColor: appBarTitleColor,
            style: const TextStyle(fontSize: 15, fontFamily: regularFont),
            decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                prefixIcon: isPrefixIconVisible
                    ? IconButton(
                        icon: Icon(backIcon,
                            size: 20, color: textFieldBackIconColor),
                        onPressed: callBackPrefix)
                    : null,
                suffixIcon: isSuffixIconVisible.value
                    ? IconButton(
                        icon: Icon(searchClearIcon,
                            size: 18, color: textFieldSuffixPrefixIconColor),
                        onPressed: callBackClear)
                    : IconButton(
                        icon: Icon(searchIcon,
                            size: 20, color: textFieldSuffixPrefixIconColor),
                        onPressed: callBackSearch),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: searchBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
