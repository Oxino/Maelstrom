import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/event_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_image.dart';

class RecoCard extends StatelessWidget {
  final EventModel event;
  RecoCard(this.event);
  final Storage _firestoreStorage = Storage();
  final BusinessRepo _businessRepos = BusinessRepo();

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    final EventBloc eventBloc = BlocProvider.of<EventBloc>(context);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ThemeColors.grayColor,
          borderRadius: BorderRadius.all((Radius.circular(10)))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BaseImage(ImageType.reco, event.imageName),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                BaseText(TextType.littleBoldText, event.name, textMaxSize: 40),
                SizedBox(height: 8),
                StreamBuilder<BusinessModel?>(
                    stream: _businessRepos.getCurrentBusiness(event.idBusiness),
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData)
                        return BaseText(
                            TextType.littleText, "Pas d'établissement",
                            textMaxSize: 30);
                      return BaseText(
                          TextType.littleText, snapshot.data!.institutionName,
                          textMaxSize: 30);
                    })),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: event.tags.map<Widget>((tag) {
                          if (event.tags.indexOf(tag) > 3) return Container();
                          return TagsWidget(TagsType.bubble, tag['name'],
                              Color(tag['colorValue']));
                        }).toList()),
                    BaseButton(ButtonsType.icon, () {

                    pageBloc.setChangePage(PageType.path);
                    eventBloc.setEvent(event);
                    }),
                  ],
                )
              ],
            )
          ]),
    );
  }
}
