import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodcafe/controller/controller.dart';
import 'package:foodcafe/resource/colors.dart';
import 'package:foodcafe/resource/images.dart';
import 'package:foodcafe/resource/style.dart';
import 'package:foodcafe/resource/value.dart';
import 'package:get/get.dart';
import 'package:foodcafe/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditPage> {
  var _key = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(titleProfileEdit, style: appBarTitleStyle)),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: ListView(children: [_formUI()])));

  _formUI() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        _profileImage(),
        widget.size(heightScale: 30.0),
        _userNameInput(),
        _mobileInput(),
        _pinCodeInput(),
        _addressInput(),
        widget.size(heightScale: 20.0),
        _profileEditPress(),
        SizedBox(height: 10.0)
      ]));

  _profileImage() => Column(children: [
        Obx(() => InkWell(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
            child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.withOpacity(0.1),
                backgroundImage: ProfileEditController.to.profileURL.value.isEmpty
                    ? ProfileEditController.to.imagePickerPath.value == null
                        ? ExactAssetImage(profileImage)
                        : FileImage(
                            File(ProfileEditController.to.imagePickerPath.value))
                    : NetworkImage(ProfileEditController.to.profileURL.value)),
            onTap: () => ImageSource.camera.getImage().then(
                (value) => ProfileEditController.to.setImagePickerPath(value)))),
        Text(ProfileEditController.to.userName.value, style: appBarTitleStyle)
      ]);

  _profileEditPress() =>
      Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: ProfileEditController.to.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _profileEditValidate());

  _profileEditValidate() {
    FocusScope.of(context).requestFocus(FocusNode());

    switch (_key.currentState.validate()) {
      case true:
        _key.currentState.save();
        ProfileEditController.to.callProfile();
        break;
      case false:
        ProfileEditController.to.checkAutoValidate();
        break;
    }
  }

  _userNameInput() =>
      widget.inputField(ProfileEditController.to.userNameController,
          validation: ProfileEditController.to.isUserNameValid,
          onChanged: ProfileEditController.to.changeUserName,
          labelText: hintUserName,
          keyboardType: TextInputType.text);

  _mobileInput() => widget.inputField(ProfileEditController.to.mobileController,
      validation: ProfileEditController.to.isMobileValid,
      onChanged: ProfileEditController.to.changeMobile,
      maxLength: mobileMaxLength,
      labelText: hintMobile,
      keyboardType: TextInputType.number);

  _pinCodeInput() => widget.inputField(ProfileEditController.to.pinCodeController,
      validation: ProfileEditController.to.isPinCodeValid,
      onChanged: ProfileEditController.to.changePinCode,
      labelText: hintPinCode,
      maxLength: pinCodeMaxLength,
      keyboardType: TextInputType.number);

  _addressInput() => widget.inputField(ProfileEditController.to.addressController,
      validation: ProfileEditController.to.isAddressValid,
      onChanged: ProfileEditController.to.changeAddress,
      labelText: hintAddress,
      keyboardType: TextInputType.text);
}
