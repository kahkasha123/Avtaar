import 'dart:io';
import 'package:flutter/material.dart';
import 'package:avtar/Utils/dimension.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? logoText;
  final String? businessId;
  final String? fileImage;

  const ProfilePictureWidget(
      {Key? key, this.logoText, this.businessId, this.fileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vpH = getViewportHeight(context);

    return Container(
      child: CircleAvatar(
          backgroundColor: Colors.purple,
          radius: vpH * 0.055,
          backgroundImage: getImage(),
          child: fileImage != null
              ? const Icon(Icons.camera_alt_outlined, color: Colors.white)
              :  Container()),
      decoration: BoxDecoration(
        color: Colors.purple,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.25))
        ],
      ),
    );
  }

  getTextFirstLetter(String text) {
    if (text.length == 1) {
      return text;
    } else {
      return text.trim().toUpperCase()[0];
    }
  }

  ImageProvider<Object>? getImage() {
    
    return (fileImage != null
        ? FileImage(File(fileImage!))
            : null);
  }
}
