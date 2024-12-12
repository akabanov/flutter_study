import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/todo_edit_screen.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_tile.dart';
import 'package:vanilla/src/ui/widget/todo_stats_view.dart';

class TodoListView extends StatefulWidget {
  static const k = Key('todo-list-view');
  static const listKey = Key('todo-list-list-view');
  static const statsKey = Key('todo-list-stats-view');

  const TodoListView(
      {super.key = const Key('todo-list-view'),
      required this.state,
      required this.addTodo,
      required this.updateTodo,
      required this.removeTodo});

  final TodoListState state;
  final TodoAction addTodo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

enum TodoListTab {
  list('Todos', Icons.list, Icons.list_outlined),
  stats('Statistics', Icons.bar_chart, Icons.bar_chart_outlined);

  final String tooltip;
  final IconData icon;
  final IconData iconOutlined;

  const TodoListTab(this.tooltip, this.icon, this.iconOutlined);

  String get navDestinationKey => 'todo-list-nav-dst-$name';
}

class _TodoListViewState extends State<TodoListView> with RestorationMixin {
  RestorableInt currentTab = RestorableInt(0);

  @override
  String get restorationId => 'todo-list-view';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(currentTab, 'tab-index');
  }

  @override
  void dispose() {
    currentTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var todos = widget.state.todos;
    var currentTabIndex = currentTab.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: currentTabIndex == 0
          ? ListView.builder(
              key: TodoListView.listKey,
              itemCount: todos.length,
              itemBuilder: (_, index) => TodoListItemTile(
                  todo: todos[index],
                  updateTodo: widget.updateTodo,
                  removeTodo: removeTodo),
            )
          : TodoStatsView(key: TodoListView.statsKey, state: widget.state),
      floatingActionButton: FloatingActionButton(
          key: Key('add-todo-btn'),
          onPressed: () =>
              Navigator.of(context).pushNamed(TodoEditScreen.addRouteName)),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentTabIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (index) {
            if (currentTabIndex != index) {
              setState(() {
                currentTab.value = index;
              });
            }
          },
          destinations: TodoListTab.values
              .map((tab) => NavigationDestination(
                    key: Key(tab.navDestinationKey),
                    icon: Icon(tab.icon),
                    selectedIcon: Icon(tab.iconOutlined),
                    tooltip: tab.tooltip,
                    label: '',
                  ))
              .toList()),
    );
  }

  void removeTodo(TodoEntity expired) {
    widget.removeTodo(expired);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('"${expired.task}" removed'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => widget.addTodo(expired),
      ),
    ));
  }
}
