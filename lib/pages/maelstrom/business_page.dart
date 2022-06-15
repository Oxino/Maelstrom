// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/business_bloc.dart';
import 'package:maelstrom/bloc/event_bloc.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/event_model.dart';

import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/business/event_calendar.dart';



// class HomePage extends BasePage {
class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventBloc eventBloc = BlocProvider.of<EventBloc>(context);
    final BusinessBloc businessBloc = BlocProvider.of<BusinessBloc>(context);
    // final currentEvent = eventBloc.streamEvent;
    return StreamBuilder<BusinessModel>(
        stream: businessBloc.streamBusiness,
        builder: ((context, snapshot) {
          if (!snapshot.hasData)
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: [
                  BaseAppBar(
                    leftIcon: 'assets/icons/arrow-back.svg',
                    leftIconFuction: PageType.list,
                    textBar: 'Evènement',
                  ),
                  Expanded(
                      child: Center(
                    child: BaseText(
                      TextType.bigText,
                      "L'évènement n'existe plus",
                    ),
                  ))
                ]));
          BusinessModel business = snapshot.data!;
          return Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseAppBar(
                          leftIcon: 'assets/icons/arrow-back.svg',
                          leftIconFuction: PageType.list,
                          textBar: business.institutionName),
                      SizedBox(height: 20),
                      BaseText(TextType.bodyBoldText, business.description),
                      SizedBox(height: 30),
                    ],
                  )),
              Column(
                children: [
                  EventCalendar(business.id),
                ],
              ),
            ],
          );
        }));
  }
}