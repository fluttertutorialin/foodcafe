import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/controller.dart';
import '../../resource/colors.dart';
import '../../resource/images.dart';
import '../../resource/style.dart';
import '../../resource/value.dart';
import '../../utils/extensions.dart';

class ProfileEditPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  ProfileEditPage({Key key}) : super(key: key);

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
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        _profileImage(),
        size(heightScale: 30.0),
        _userNameInput(),
        _mobileInput(),
        _pinCodeInput(),
        _addressInput(),
        size(heightScale: 20.0),
        _profileEditPress(),
        const SizedBox(height: 10.0)
      ]));

  _profileImage() => Column(children: [
        Obx(() => InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
            child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.withOpacity(0.1),
                backgroundImage: ProfileEditController.to.profileURL.value.isEmpty
                    ? ProfileEditController.to.imagePickerPath.value == null
                        ? const ExactAssetImage(profileImage)
                        : FileImage(
                            File(ProfileEditController.to.imagePickerPath.value))
                    : NetworkImage(ProfileEditController.to.profileURL.value)),
            onTap: () => ImageSource.camera.getImage().then(
                (value) => ProfileEditController.to.setImagePickerPath(value)))),
        Text(ProfileEditController.to.userName.value, style: appBarTitleStyle)
      ]);

  _profileEditPress() =>
      const Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: ProfileEditController.to.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _profileEditValidate());

  _profileEditValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

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
      inputField(ProfileEditController.to.userNameController,
          validation: ProfileEditController.to.isUserNameValid,
          onChanged: ProfileEditController.to.changeUserName,
          labelText: hintUserName,
          keyboardType: TextInputType.text);

  _mobileInput() => inputField(ProfileEditController.to.mobileController,
      validation: ProfileEditController.to.isMobileValid,
      onChanged: ProfileEditController.to.changeMobile,
      maxLength: mobileMaxLength,
      labelText: hintMobile,
      keyboardType: TextInputType.number);

  _pinCodeInput() => inputField(ProfileEditController.to.pinCodeController,
      validation: ProfileEditController.to.isPinCodeValid,
      onChanged: ProfileEditController.to.changePinCode,
      labelText: hintPinCode,
      maxLength: pinCodeMaxLength,
      keyboardType: TextInputType.number);

  _addressInput() => inputField(ProfileEditController.to.addressController,
      validation: ProfileEditController.to.isAddressValid,
      onChanged: ProfileEditController.to.changeAddress,
      labelText: hintAddress,
      keyboardType: TextInputType.text);
}
