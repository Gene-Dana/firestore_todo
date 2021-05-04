import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/home.dart';
import '../../filtered_todos/filtered_todos.dart';
import '../../stats/stats.dart';
import '../../todos/todos.dart';
import 'package:todos_repository/todos_repository.dart';

class HomePage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: HomePage());

  final _todosRepository = FirebaseTodosRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _todosRepository,
      child: BlocProvider(
        create: (_) => TodosBloc(
          todosRepository: _todosRepository,
        )..add(LoadTodos()),
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeTabBloc>(
          create: (context) => HomeTabBloc(),
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
        BlocProvider<StatsBloc>(
          create: (context) => StatsBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Firestore Todos'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/addTodo');
              print('pushed');
            },
            child: Icon(Icons.add),
            tooltip: 'Add Todo',
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<HomeTabBloc>(context).add(UpdateHomeTab(tab)),
          ),
        );
      },
    );
  }
}
