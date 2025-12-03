import 'package:flutter/material.dart';
import 'package:simple_planner/constants/app_constants.dart';
import 'package:simple_planner/database/database.dart';

/// Todo 카드 위젯
class TodoCard extends StatelessWidget {
  final Todo todo;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;

  const TodoCard({
    super.key,
    required this.todo,
    required this.index,
    required this.onDelete,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
      child: ListTile(
        leading: _AnimatedCheckBox(
          value: todo.isDone,
          onChanged: (_) => onToggleComplete(),
        ),
        title: _TodoTitle(todo: todo),
        trailing: _TodoActionButtons(index: index, onDelete: onDelete),
      ),
    );
  }
}

/// Todo 제목 위젯 (반복 아이콘 포함)
class _TodoTitle extends StatelessWidget {
  final Todo todo;

  const _TodoTitle({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (todo.recurringId != null)
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.tinyPadding),
            child: Icon(
              Icons.repeat,
              size: AppConstants.smallIconSize,
              color: AppColors.lightGreyIcon,
            ),
          ),
        Expanded(
          child: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: todo.isDone ? Colors.grey : null,
            ),
          ),
        ),
      ],
    );
  }
}

/// Todo 액션 버튼들 (삭제, 드래그)
class _TodoActionButtons extends StatelessWidget {
  final int index;
  final VoidCallback onDelete;

  const _TodoActionButtons({required this.index, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.grey,
          splashColor: Colors.red.withValues(alpha: AppConstants.mediumOpacity),
          highlightColor: Colors.red.withValues(alpha: AppConstants.lowOpacity),
          onPressed: onDelete,
        ),
        ReorderableDragStartListener(
          index: index,
          child: IconButton(
            icon: const Icon(Icons.drag_handle, color: Colors.grey),
            splashColor: primaryColor.withValues(
              alpha: AppConstants.mediumOpacity,
            ),
            highlightColor: primaryColor.withValues(
              alpha: AppConstants.lowOpacity,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _AnimatedCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _AnimatedCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_AnimatedCheckBox> createState() => _AnimatedCheckBoxState();
}

class _AnimatedCheckBoxState extends State<_AnimatedCheckBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });

    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Checkbox(
        value: widget.value,
        onChanged: (_) => _handleTap(),
        activeColor: Colors.green,
      ),
    );
  }
}
