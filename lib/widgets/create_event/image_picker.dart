import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';

class ImagePicker extends StatefulWidget {
  var setImageControllers;
  String imagePathController = '';
  String imageNameController = '';

  ImagePicker(
    this.setImageControllers,
    this.imagePathController,
    this.imageNameController, {
    Key? key,
  }) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _getImage(),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
                color: ThemeColors.grayColor),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    TextType.bodyText,
                    'Son image',
                    textColor: widget.imagePathController != ''
                        ? ThemeColors.whiteColor
                        : ThemeColors.textUnfocusColor,
                  ),
                  SizedBox(
                      height: 20, // Your Height
                      width: 20,
                      child: SvgPicture.asset(
                        'assets/icons/picture.svg',
                        color: widget.imagePathController != ''
                            ? ThemeColors.whiteColor
                            : ThemeColors.textUnfocusColor,
                      )),
                ],
              ),
              if (widget.imagePathController != '') SizedBox(height: 20),
              if (widget.imagePathController != '')
                // BaseImage(ImageType.big, widget.imagePathController),
                Container(
                    width: 354.toDouble(),
                    height: 181.toDouble(),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          File(widget.imagePathController),
                          fit: BoxFit.cover,
                        )))
            ])));
    // onPressed: () =>
    //     widget.isDate ? _selectDate(context) : _selectTime(context)));
  }

  _getImage() async {
    final image = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            BaseText(TextType.bodyBoldText, "Veuillez selectionner un fichier"),
        backgroundColor: ThemeColors.errorColor,
      ));
      return null;
    }
    widget.setImageControllers(
        image.files.single.path!, image.files.single.name);
  }
}
