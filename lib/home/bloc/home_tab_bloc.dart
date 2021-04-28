import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_tab_event.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, AppTab> {
  HomeTabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(
    HomeTabEvent event,
  ) async* {
    if (event is UpdateHomeTab) {
      yield event.tab;
    }
  }
}
