import 'dart:async';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/config.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc implements BlocBase {
  // PageType _page = PageType.home;

  BehaviorSubject<PageType> _pageController = BehaviorSubject<PageType>();
  StreamSink<PageType> get sinkPage => _pageController.sink;
  Stream<PageType> get streamPage => _pageController.stream;

  setChangePage(PageType type) {
    _pageController.sink.add(type);
  }

  void dispose() {
    _pageController.close();
  }
}
