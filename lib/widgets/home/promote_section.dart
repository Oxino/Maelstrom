import 'package:flutter/material.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/home/promote_widget.dart';

class PromoteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventRepos _eventRepos = EventRepos();
    return StreamBuilder<List<EventModel?>>(
        stream: _eventRepos.getTodayPromoteEvents(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return Container();
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:
                    BaseText(TextType.sectionTitle, "Evènement de la soirée"),
              ),
              SizedBox(height: 15),
              Column(
                  children: snapshot.data!.map((event) {
                if (event != null) {
                  return Column(
                    children: [PromoteWidget(event)],
                  );
                } else {
                  return Container();
                }
              }).toList())
            ],
          );
        }));
  }
}
