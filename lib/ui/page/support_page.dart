import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class SupportPage extends StatelessWidget {
  final _supportController = Get.put(SupportController());
  final _key = GlobalKey<FormState>();

  SupportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor))),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('We are Happy to\nhear from you!!',
                          style: supportTitleStyle),
                      Text('Let us know your queries & Feedbacks.',
                          style: supportSubTitleStyle),
                      const SizedBox(height: 30),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.deepOrange,
                                  border: Border.all(color: Colors.red[500])),
                              padding: const EdgeInsets.all(8),
                              child: Row(children: [
                                Icon(phoneSquareIcon,
                                    size: 20, color: Colors.white),
                                Text('CALL NOW', style: supportCallNowStyle)
                              ]))),
                      const SizedBox(height: 10),
                      Text('Sent your message',
                          style: supportSentMessageTitleStyle),
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(children: [
                            _userNameInput(),
                            _emailInput(),
                            _mobileInput(),
                            _messageInput(),
                            size(heightScale: 20.0),
                            _supportPress(),
                            const SizedBox(height: 10.0)
                          ]))
                    ]))
          ])));

  _supportPress() => const Align(alignment: Alignment.bottomCenter).customFloatForm(
      color: appBarTitleColor,
      stateStatus: _supportController.stateStatus.value,
      icon: Icons.navigate_next,
      isMini: false,
      qrCallback: () => _supportValidate());

  _supportValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        _supportController.callSupport();
        break;
      case false:
        _supportController.checkAutoValidate();
        break;
    }
  }

  _userNameInput() => inputField(_supportController.userNameController,
      validation: _supportController.isUserNameValid,
      onChanged: _supportController.changeUserName,
      labelText: hintUserName,
      keyboardType: TextInputType.text);

  _emailInput() => inputField(_supportController.emailController,
      validation: _supportController.isEmailValid,
      onChanged: _supportController.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);

  _mobileInput() => inputField(_supportController.mobileController,
      validation: _supportController.isMobileValid,
      onChanged: _supportController.changeMobile,
      labelText: hintMobile,
      maxLength: mobileMaxLength,
      keyboardType: TextInputType.number);

  _messageInput() => inputField(_supportController.messageController,
      validation: _supportController.isMessageValid,
      onChanged: _supportController.changeMessage,
      labelText: hintMessage,
      maxLength: messageMaxLength,
      keyboardType: TextInputType.text);
}
