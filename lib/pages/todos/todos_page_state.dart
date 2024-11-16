import 'package:flutter/material.dart';

import 'package:mood_n_habbits/models/app_state.dart';
import 'package:mood_n_habbits/utils/todos_state_mixin.dart';

class TodosPageState with TodosStateMixin {
  TodosPageState(AppState appState) {
    this.appState = appState;
    loadTodos();
  }

  final ValueNotifier<bool> reordering = ValueNotifier(false);

  void clearFinished() async {
    await appState.clearFinishedTodos();
    loadTodos();
  }

  void toggleReordering() => reordering.value = !reordering.value;

  void onReorder(int oldIndex, int newIndex) async {
    final todos = this.todos.value!;

    final fromId = todos[oldIndex].databaseId!;
    final toId = newIndex == 0 ? null : todos[newIndex - 1].databaseId!;

    if (newIndex > oldIndex) newIndex--;
    if (oldIndex == newIndex) return;

    todos.insert(newIndex, todos.removeAt(oldIndex));

    this.todos.value = todos;

    await appState.changeTodoOrders(fromId, toId);
    loadTodos(shouldNotBeChanged: false);
  }
}
