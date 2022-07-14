import 'package:flutter/material.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_image.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class EventPath extends StatefulWidget {
  EventModel? event;
  EventPath(this.event, {Key? key}) : super(key: key);

  @override
  State<EventPath> createState() => _EventPathState();
}

class _EventPathState extends State<EventPath> {
  final BusinessRepo _businessRepos = BusinessRepo();

  @override
  Widget build(BuildContext context) {
    bool hasSelectedEvent = widget.event != null;
    if (hasSelectedEvent) {
      EventModel event = widget.event!;
      String businessName = "Pas d'établissement";
      Stream<BusinessModel> stream =
          _businessRepos.getCurrentBusiness(event.idBusiness);
      stream.listen((business) {
        businessName = business.institutionName;
      });
      return Container(
        height: 150,
          padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: ThemeColors.grayColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Expanded(
                      child: BaseText(TextType.sectionTitle, event.name),
                    ),
                  ),
                  Container(width: 50, child:  BaseText(TextType.bigText, '2km'))
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BaseText(TextType.sectionTitle, businessName),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: event.tags.map<Widget>((tag) {
                        if (event.tags.indexOf(tag) > 3) return Container();
                        return TagsWidget(TagsType.bubble, tag['name'],
                            Color(tag['colorValue']));
                      }).toList()),
                ],
              ),
            ],
          ));
    }
    return Container();
  }
}
