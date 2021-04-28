part of 'home_tab_bloc.dart';

abstract class HomeTabEvent extends Equatable {
  const HomeTabEvent();
}

class UpdateHomeTab extends HomeTabEvent {
  final AppTab tab;

  const UpdateHomeTab(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'UpdateHomeTab { tab: $tab }';
}

enum AppTab { todos, stats }
