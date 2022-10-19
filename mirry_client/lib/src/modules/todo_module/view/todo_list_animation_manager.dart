import 'package:flutter/material.dart';
import 'package:mirry_client/src/modules/todo_module/view/todo_item_view.dart';
import 'package:mirry_client/src/modules/todo_module/view/todo_list_item_transition.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_item.dart';

class TodoListAnimationManager extends StatefulWidget {
  final Widget child;
  final List<TodoItem> items;
  final GlobalKey<AnimatedListState> listKey;

  const TodoListAnimationManager({
    Key? key,
    this.items = const [],
    required this.listKey,
    required this.child,
  }) : super(key: key);

  @override
  State<TodoListAnimationManager> createState() =>
      _TodoListAnimationManagerState();
}

class _TodoListAnimationManagerState extends State<TodoListAnimationManager> {
  @override
  void initState() {
    super.initState();
    _findAndAnimateDifferences(widget.items);
  }

  @override
  void didUpdateWidget(covariant TodoListAnimationManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    _findAndAnimateDifferences(
      widget.items,
      oldList: oldWidget.items,
    );
  }

  void _findAndAnimateDifferences(
    List<TodoItem> newList, {
    List<TodoItem> oldList = const [],
  }) {
    _findIndexDifferences(newList, oldList).forEach((index) {
      widget.listKey.currentState?.insertItem(index);
    });
    _findIndexDifferences(oldList, newList).reversed.forEach((index) {
      final item = oldList[index];

      widget.listKey.currentState?.removeItem(
        index,
        (context, animation) => TodoListItemTransition(
          animation: animation,
          child: TodoItemView(todoItem: item),
        ),
      );
    });
  }

  List<int> _findIndexDifferences(
    List<TodoItem> a, [
    List<TodoItem> b = const [],
  ]) {
    final aIds = a.map((e) => e.id).toList();
    final bIds = b.map((e) => e.id).toList();

    final difference = aIds.toSet().difference(bIds.toSet());
    return difference.map<int>((id) => aIds.indexOf(id)).toList();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
