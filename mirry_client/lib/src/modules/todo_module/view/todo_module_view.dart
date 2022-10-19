import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/todo_module/bloc/todo_module_bloc.dart';
import 'package:mirry_client/src/modules/todo_module/bloc/todo_module_bloc_provider.dart';
import 'package:mirry_client/src/modules/todo_module/view/todo_item_view.dart';
import 'package:mirry_client/src/modules/todo_module/view/todo_list_animation_manager.dart';
import 'package:mirry_client/src/modules/todo_module/view/todo_list_item_transition.dart';

class TodoModuleView extends StatefulWidget {
  const TodoModuleView({Key? key}) : super(key: key);

  @override
  State<TodoModuleView> createState() => _TodoModuleViewState();
}

class _TodoModuleViewState extends State<TodoModuleView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return TodoModuleBlocProvider(
      child: BlocBuilder<TodoModuleBloc, TodoModuleState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                width: 250,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: TodoListAnimationManager(
                  listKey: _listKey,
                  items: state.todoItems,
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: state.todoItems.isNotEmpty
                        ? state.todoItems.length - 1
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index, animation) {
                      final item = state.todoItems[index];
                      final isLast = index == state.todoItems.length - 1;
                      return TodoListItemTransition(
                        animation: animation,
                        child: TodoItemView(
                          todoItem: item,
                          isLastItem: isLast,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
