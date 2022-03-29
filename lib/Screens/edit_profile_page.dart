
import 'package:avtar/Utils/user_preferences.dart';
import 'package:avtar/Widgets/profile_picture.dart';
import 'package:avtar/model/user.dart';
import 'package:avtar/sheets/image_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avtar/Utils/dimension.dart';
import 'package:avtar/Widgets/profile_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    final TextEditingController _fullNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneNumberController = TextEditingController();
     final TextEditingController _genderController = TextEditingController();
    final TextEditingController _countryController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final ValueNotifier<XFile?> pickedImageFile = ValueNotifier(null);
    bool isEditingEnabled = false;

  @override
  Widget build(BuildContext context) {
    final vpH = getViewportHeight(context);
    final vpW = getViewportWidth(context);
    User user = UserPreferences.myUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: vpH * 0.03),
                      ValueListenableBuilder<XFile?>(
                          valueListenable: pickedImageFile,
                          builder: (context, value, child) {
                            return GestureDetector(
                              child: ProfilePictureWidget(
                                fileImage: pickedImageFile.value?.path,
                              ),
                              onTap: () async {
                                isEditingEnabled ?
                                await showImagePickerSheet(
                                    context, pickedImageFile):null;
                              },
                            );
                          }),
                      
                      SizedBox(
                        height: vpH * 0.02,
                      ),
                      ProfileTextField(
                          isEditingEnabled: isEditingEnabled, 
                          iconData: Icons.person,
                          textCapitalization: TextCapitalization.words,
                          textEditingController: _fullNameController,
                          labelText: "Full Name",
                          initText: user.name,
                          type: TextInputType.name,
                          
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Full Name is required";
                            }
                            return null;
                          }),
                          ProfileTextField(
                            isEditingEnabled: isEditingEnabled,
                          iconData: Icons.person_pin,
                          labelText: "Gender",
                          textCapitalization: TextCapitalization.words,
                          textEditingController: _genderController,
                          initText: user.gender,
                          type: TextInputType.name,
                          
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Gender is required";
                            }
                            return null;
                          },
                          ),
                          ProfileTextField(
                            isEditingEnabled: isEditingEnabled,
                          iconData: Icons.email,
                          initText: user.email,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (value.isNotEmpty) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Invalid Email";
                              }
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                          textEditingController: _emailController,
                          labelText: "Email"),
                      ProfileTextField(
                        isEditingEnabled: isEditingEnabled,
                          iconData: Icons.person,
                          textEditingController: _phoneNumberController,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Phone Number is required";
                            }
                            if (value.isNotEmpty) {
                              if (value.length != 10) {
                                return "Invalid Phone Number";
                              }
                            }
                            return null;
                          },
                          maxLength: 10,
                          type: TextInputType.phone,
                          labelText: "Phone Number",
                          initText: user.phoneNumber,),

                          ProfileTextField(
                            isEditingEnabled: isEditingEnabled,
                          iconData: Icons.location_city,
                          textCapitalization: TextCapitalization.words,
                          textEditingController: _countryController,
                          labelText: "Country",
                          initText: user.country,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Country is required";
                            }
                            return null;
                          }),
                          ProfileTextField(
                            isEditingEnabled: isEditingEnabled,
                          iconData: Icons.location_city_outlined,
                          textCapitalization: TextCapitalization.words,
                          textEditingController: _cityController,
                          labelText: "City",
                          initText: user.city,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "City is required";
                            }
                            return null;
                          }),
                          isEditingEnabled ?
                          Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                onPressed: () {
                  user.name = _fullNameController.text;
                  user.gender = _genderController.text;
                  user.email = _emailController.text;
                  user.phoneNumber = _phoneNumberController.text;
                  user.country = _countryController.text;
                  user.city = _cityController.text;
                  setState(() {
                    isEditingEnabled = false;
                  });
                }, 
                child: Text ("Save",
                style: TextStyle(fontSize: vpH * 0.055, fontWeight: FontWeight.bold, color: Colors.purple)),
              ),
              SizedBox(width: vpW * 0.035),
              TextButton(
                onPressed: () { 
                  setState(() {
                    isEditingEnabled = false;
                  });
                 },
                child: Text ("Cancel",
                style: TextStyle(fontSize: vpH * 0.055, fontWeight: FontWeight.bold, color: Colors.purple), 
                ),
              )
            ],) : TextButton(
                onPressed: () {
                  setState(() {
                    isEditingEnabled = true;
                  });
                }, 
                child: Text ("Edit",
                style: TextStyle(fontSize: vpH * 0.055, fontWeight: FontWeight.bold, color: Colors.purple)),
              )

                    ],
                  ),)
      ),// This trailing comma makes auto-formatting nicer for build methods.
    ));
  }

}
