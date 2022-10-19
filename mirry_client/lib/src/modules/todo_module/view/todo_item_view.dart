import 'package:flutter/material.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_item.dart';
import 'package:mirry_client/src/widgets/list_divider.dart';

class TodoItemView extends StatelessWidget {
  final TodoItem todoItem;
  final bool isLastItem;

  const TodoItemView({
    Key? key,
    required this.todoItem,
    this.isLastItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: todoItem.isDone,
                onChanged: (_) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                activeColor: Colors.grey.shade800,
                checkColor: Colors.grey.shade600,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: !todoItem.isDone
                        ? Theme.of(context).textTheme.titleSmall!
                        : Theme.of(context).textTheme.titleSmall!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.white.withOpacity(0.2),
                            ),
                    child: Text(
                      todoItem.title,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: !todoItem.isDone
                        ? Theme.of(context).textTheme.caption!
                        : Theme.of(context).textTheme.caption!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.white.withOpacity(0.2),
                            ),
                    child: Text(
                      todoItem.description,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
          if (!isLastItem) const ListDivider(),
        ],
      ),
    );
  }
}
