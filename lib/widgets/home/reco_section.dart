import 'package:flutter/material.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/clickable_event.dart';
import 'package:maelstrom/widgets/home/reco_card.dart';

class RecoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventRepos _eventRepos = EventRepos();
    return StreamBuilder<List<EventModel?>>(
        stream: _eventRepos.getTodayEvents([]),
        builder: ((context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              child: BaseText(
                TextType.bodyBoldText,
                "Pas d'évènement aujourd'hui",
              ),
            );
          return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 10,
                mainAxisExtent: 230,
              ),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: snapshot.data!.map((event) {
                if (event != null) {
                  return ClickableEvent(event.idBusiness, RecoCard(event));
                } else {
                  return Container();
                }
              }).toList());
        }));
  }
}
