import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/event_bloc.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/calendar_event_model.dart';

import 'package:maelstrom/repositories/event/event_repo.dart';

import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/business/date_item.dart';
import 'package:maelstrom/widgets/business/event_widget.dart';
import 'package:maelstrom/widgets/dashboard/data_box.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';

class BusinessEventPage extends StatefulWidget {
  BusinessEventPage({Key? key}) : super(key: key);

  @override
  State<BusinessEventPage> createState() => _BusinessEventPageState();
}

class _BusinessEventPageState extends State<BusinessEventPage> {
  final EventRepos _eventRepos = EventRepos();
  int? currentItemActive = null;
  @override
  Widget build(BuildContext context) {
    final EventBloc eventBloc = BlocProvider.of<EventBloc>(context);
    return StreamBuilder<EventModel>(
        stream: eventBloc.streamEvent,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          EventModel event = snapshot.data!;
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseAppBar(
                              leftIcon: 'assets/icons/arrow-back.svg',
                              leftIconFuction: PageType.businessEvent,
                              textBar: 'Votre événement'),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: DataBox(
                                    'Vue', 8224, 'assets/icons/data_see.svg'),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: DataBox('Prévu', 852,
                                    'assets/icons/data_provide.svg'),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: DataBox(
                                    'Venu', 1644, 'assets/icons/data_go.svg'),
                              )
                            ],
                          ),
                        ])),
                EventWidget(
                  event,
                  isBusiness: true,
                ),
              ]);
        }));
  }
}
