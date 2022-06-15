// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';

import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/list/choose_tag.dart';
import 'package:maelstrom/widgets/list/event_item_list.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final EventRepos _eventRepos = EventRepos();

  List activeTags = [];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      BaseAppBar(textBar: "Liste d'évènement"),
      ChooseTag(setActiveTags, activeTags),
      SizedBox(height: 20),
      Expanded(
          child: SingleChildScrollView(
              child: StreamBuilder<List<EventModel?>>(
                  stream: _eventRepos.getTodayEvents(activeTags),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        child: BaseText(
                          TextType.bodyBoldText,
                          "Pas d'évènement corespondant a votre recherche",
                        ),
                      );
                    return Column(
                        children: snapshot.data!.map((event) {
                      if (event != null) {
                        return EventItemList(event);
                      } else {
                        return Container();
                      }
                    }).toList());
                  }))))
    ]);
  }

  void setActiveTags(Map value) => setState(() {
        activeTags.contains(value)
            ? activeTags.remove(value)
            : activeTags.add(value);

        activeTags.sort((a, b) => a["name"].compareTo(b["name"]));
      });
}
