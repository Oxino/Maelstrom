import 'dart:io';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';

class BaseImage extends StatelessWidget {
  final ImageType imageType;
  final String imageSrc;
  final String imageKm;
  BaseImage(ImageType this.imageType, String this.imageSrc,
      [String this.imageKm = ""]);
  @override
  Widget build(BuildContext context) {
    return
        //  AspectRatio(
        //     aspectRatio: _buildImageSize(imageType),
        // Container(
        //     width: _buildImageSize(imageType)[0],
        //     height: _buildImageSize(imageType)[1],
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(6)),
        //     image: DecorationImage(
        //       image: AssetImage(
        //         imageSrc,
        //       ),
        //       fit: BoxFit.cover,
        //     )),
        // child:
        Column(children: [
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(imageSrc),
            ),
          ),
          width: _buildImageSize(imageType)[0],
          height: _buildImageSize(imageType)[1],
          child: null),
      if (imageType == ImageType.reco)
        Stack(
          children: [
            Positioned(
              top: 75,
              right: 0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 3, 1),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(6)),
                    color: ThemeColors.grayColor,
                  ),
                  child: BaseText(TextType.littleBoldText, imageKm)),
            ),
          ],
        )
    ]);
  }

  _buildImageSize(ImageType type) {
    switch (type) {
      case ImageType.big:
        {
          return [354.toDouble(), 181.toDouble()];
          // return 354 / 181.toDouble();
        }

      case ImageType.promote:
        {
          return [125.toDouble(), 77.toDouble()];
          // return 125 / 77.toDouble();
        }

      case ImageType.reco:
        {
          return [134.toDouble(), 92.toDouble()];
          // return 134 / 92.toDouble();
        }
      case ImageType.smallSquare:
        {
          return [52.toDouble(), 52.toDouble()];
          // return 52 / 52.toDouble();
        }
      case ImageType.square:
        {
          return [60.toDouble(), 60.toDouble()];
          // return 60 / 60.toDouble();
        }

      default:
        {
          return [134.toDouble(), 92.toDouble()];
          // return 134 / 92.toDouble();
        }
    }
  }
}
