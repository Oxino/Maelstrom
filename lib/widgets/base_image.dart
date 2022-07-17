import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';

class BaseImage extends StatelessWidget {
  final ImageType imageType;
  final String imageName;
  final String imageKm;
  BaseImage(ImageType this.imageType, String this.imageName,
      [String this.imageKm = ""]);
  @override
  Widget build(BuildContext context) {
    final Storage _firestoreStorage = Storage();
    return FutureBuilder(
      future: _firestoreStorage.getImageURL(imageName),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        bool hasData = snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData;
        bool connexionState = snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting;
        return Container(
          width: _buildImageSize(imageType)[0],
          height: _buildImageSize(imageType)[1],
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: hasData
                  ? Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center();
                      },
                    )
                  : connexionState
                      ? Container()
                      // FittedBox(
                      //     child: Image.asset(
                      //         'assets/images/default_picture_3.png'),
                      //     fit: BoxFit.cover,
                      //   )
                      : Container()),
        );
      },
    );
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
