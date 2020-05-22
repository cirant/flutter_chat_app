import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePiker extends StatefulWidget {
  UserImagePiker({Key key, this.imagePickerFn}) : super(key: key);

  final void Function(File file) imagePickerFn;

  @override
  _UserImagePikerState createState() => _UserImagePikerState();
}

class _UserImagePikerState extends State<UserImagePiker> {
  File _pickedImageFile;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    widget.imagePickerFn(pickedImageFile);

    setState(() {
      _pickedImageFile = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('add picture'),
        ),
      ],
    );
  }
}
