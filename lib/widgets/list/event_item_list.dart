import 'package:flutter/material.dart';

import 'package:maelstrom/bloc/business_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';

import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';

import 'package:maelstrom/widgets/base_image.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class EventItemList extends StatelessWidget {
  final EventModel event;
  EventItemList(this.event);
  final Storage _firestoreStorage = Storage();
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    final BusinessBloc businessBloc = BlocProvider.of<BusinessBloc>(context);

    final BusinessRepo _businessRepo = BusinessRepo();
    // final curentEvent = _businessRepo.getCurrentBusiness(event.idBusiness);
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: StreamBuilder<BusinessModel>(
            stream: _businessRepo.getCurrentBusiness(event.idBusiness),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return BaseText(TextType.bodyBoldText, "Something went wrong");
              }

              return InkWell(
                  onTap: () {
                    pageBloc.setChangePage(PageType.event);
                    if (snapshot.data != null) {
                      businessBloc.setBusiness(snapshot.data!);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                        color: ThemeColors.grayColor,
                        borderRadius: BorderRadius.all((Radius.circular(10)))),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                            future:
                                _firestoreStorage.getImageURL(event.imageName),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return BaseImage(
                                    ImageType.smallSquare, snapshot.data!);
                              }
                              if (snapshot.hasData ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              return Container();
                            },
                          ),
                          SizedBox(width: 8),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      flex: 5,
                                      child: BaseText(
                                          TextType.littleBoldText, event.name,
                                          textMaxSize: 55)),
                                  Flexible(
                                      flex: 1,
                                      child: BaseText(
                                          TextType.littleBoldText, '2km')),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: event.tags.map<Widget>((tag) {
                                    if (event.tags.indexOf(tag) > 3)
                                      return Container();
                                    return TagsWidget(TagsType.small,
                                        tag['name'], Color(tag['colorValue']));
                                  }).toList()),
                            ],
                          )),
                        ]),
                  ));
            })));
  }
}
