import 'dart:async';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:rxdart/rxdart.dart';

class BusinessBloc implements BlocBase {
  // PageType _page = PageType.home;

  BehaviorSubject<BusinessModel> _businessController =
      BehaviorSubject<BusinessModel>();
  StreamSink<BusinessModel> get sinkBusiness => _businessController.sink;
  Stream<BusinessModel> get streamBusiness => _businessController.stream;

  setBusiness(BusinessModel business) {
    sinkBusiness.add(business);
  }

  void dispose() {
    _businessController.close();
  }
}
