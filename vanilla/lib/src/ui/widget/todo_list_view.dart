import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_view.dart';
import 'package:vanilla/src/ui/widget/todo_stats_view.dart';

class TodoListView extends StatefulWidget {
  const TodoListView(
      {super.key,
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
}

class _TodoListViewState extends State<TodoListView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    var todos = widget.state.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: SafeArea(
        child: currentTab == 0
            ? ListView.builder(
                itemCount: todos.length,
                itemBuilder: (_, index) => TodoListItemView(
                    todo: todos[index],
                    updateTodo: widget.updateTodo,
                    removeTodo: removeTodo),
              )
            : TodoStatsView(state: widget.state),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentTab,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (index) {
            if (currentTab != index) {
              setState(() {
                currentTab = index;
              });
            }
          },
          destinations: TodoListTab.values
              .map((tab) => NavigationDestination(
                    key: Key('todo-list-nav-btn-${tab.name}'),
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
