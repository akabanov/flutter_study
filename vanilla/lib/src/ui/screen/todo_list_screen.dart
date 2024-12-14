import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/todo_edit_screen.dart';
import 'package:vanilla/src/ui/widget/content_loading_view.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_tile.dart';
import 'package:vanilla/src/ui/widget/todo_stats_view.dart';

class TodoListScreen extends StatefulWidget {
  static const k = Key('todo-list-screen');
  static const listKey = Key('todo-list-list-view');
  static const statsKey = Key('todo-list-stats-view');

  static const routeName = '/';

  const TodoListScreen(
      {super.key = k,
      required this.addTodo,
      required this.updateTodo,
      required this.removeTodo});

  final TodoAction addTodo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
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

class _TodoListScreenState extends State<TodoListScreen> with RestorationMixin {
  RestorableInt currentTab = RestorableInt(0);

  @override
  String get restorationId => 'todo-list-screen';

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
    var state = Provider.of<TodoListState>(context, listen: true);
    var todos = state.todos;
    var currentTabIndex = currentTab.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: switch ((state.status, currentTabIndex)) {
        (TodoListStateStatus.loading, _) => ContentLoadingView(),
        (_, 1) => TodoStatsView(key: TodoListScreen.statsKey, state: state),
        _ => ListView.builder(
            key: TodoListScreen.listKey,
            itemCount: todos.length,
            itemBuilder: (_, index) => TodoListItemTile(
                todo: todos[index],
                updateTodo: (todo) => _update(widget.updateTodo, todo),
                removeTodo: removeTodo),
          )
      },
      floatingActionButton: FloatingActionButton(
        key: Key('add-todo-btn'),
        onPressed: () => context.push(TodoEditScreen.addRouteName),
        child: Icon(Icons.add),
      ),
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
    _update(widget.removeTodo, expired);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('"${expired.task}" removed'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => _update(widget.addTodo, expired),
      ),
    ));
  }

  void _update(TodoAction action, TodoEntity todo) {
    setState(() {
      action(todo);
    });
  }
}
