import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/clickable_event.dart';

class BusinessItemList extends StatelessWidget {
  final String businessId;
  BusinessItemList(this.businessId);

  final BusinessRepo _businessRepos = BusinessRepo();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BusinessModel?>(
        stream: _businessRepos.getCurrentBusiness(businessId),
        builder: ((context, snapshot) {
          if (!snapshot.hasData)
            return BaseText(TextType.littleText, "Vous n'avez pas de favoris",
                textMaxSize: 30);
          BusinessModel business = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ClickableEvent(
                business.id,
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                        color: ThemeColors.grayColor,
                        borderRadius: BorderRadius.all((Radius.circular(10)))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BaseText(
                            TextType.bodyBoldText, business.institutionName),
                        SizedBox(height: 5),
                        BaseText(TextType.littleBoldText, business.address),
                      ],
                    ))),
          );
        }));
  }
}
