import 'package:flutter/material.dart';

import 'package:maelstrom/bloc/business_bloc.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';

import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';

import 'package:maelstrom/widgets/base_text.dart';

class ClickableEvent extends StatelessWidget {
  final String idBusiness;
  final Widget widget;
  ClickableEvent(String this.idBusiness, Widget this.widget);

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    final BusinessBloc businessBloc = BlocProvider.of<BusinessBloc>(context);

    final BusinessRepo _businessRepo = BusinessRepo();
    return StreamBuilder<BusinessModel>(
        stream: _businessRepo.getCurrentBusiness(idBusiness),
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
            child: widget,
          );
        }));
  }
}
