import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> showImagePickerSheet(context, ValueNotifier<XFile?> imageFile) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text(
                    'Photo Library',
                  ),
                  onTap: () {
                    _imgFromGallery(imageFile);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text(
                  'Camera',
                ),
                onTap: () {
                  _imgFromCamera(imageFile);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}

_imgFromCamera(ValueNotifier<XFile?> imageFile) async {
  ImagePicker _imagePicker = ImagePicker();
  XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50);
  imageFile.value = image;
}

_imgFromGallery(ValueNotifier<XFile?> imageFile) async {
  ImagePicker _imagePicker = ImagePicker();
  XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50);
  imageFile.value = image;
}
