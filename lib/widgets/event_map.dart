import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/event_bloc.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/clickable_event.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class EventMap extends StatefulWidget {
  EventModel? event;
  EventMap(this.event, {Key? key}) : super(key: key);

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    final EventBloc eventBloc = BlocProvider.of<EventBloc>(context);
    bool hasSelectedEvent = widget.event != null;
    if (hasSelectedEvent) {
      EventModel event = widget.event!;
      return ClickableEvent(
          event.idBusiness,
          Container(
              height: 225,
              padding:
                  EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: ThemeColors.grayColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(TextType.pageTitle, event.name),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: event.tags.map<Widget>((tag) {
                              if (event.tags.indexOf(tag) > 3)
                                return Container();
                              return TagsWidget(TagsType.big, tag['name'],
                                  Color(tag['colorValue']));
                            }).toList()),
                        SizedBox(height: 30),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(TextType.bigText, '2km'),
                      BaseButton(ButtonsType.big, () {
                        pageBloc.setChangePage(PageType.path);
                        eventBloc.setEvent(event);
                      })
                    ],
                  )
                ],
              )));
    }
    return Container();
  }
}
