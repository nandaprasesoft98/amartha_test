import '../../../domain/entity/add_todo_list_parameter.dart';
import '../../../domain/entity/change_todo_list_parameter.dart';
import '../../../domain/entity/get_todo_list_parameter.dart';
import '../../../domain/entity/mark_todo_list_parameter.dart';
import '../../../domain/entity/remove_todo_list_parameter.dart';
import '../../../domain/entity/todo.dart';
import '../../../misc/processing/future_processing.dart';

abstract class TodoDataSource {
  FutureProcessing<List<Todo>> getTodoList(GetTodoListParameter getTodoListParameter);
  FutureProcessing<bool> addTodoList(AddTodoListParameter addTodoListParameter);
  FutureProcessing<bool> changeTodoList(ChangeTodoListParameter changeTodoListParameter);
  FutureProcessing<bool> removeTodoList(RemoveTodoListParameter deleteTodoListParameter);
  FutureProcessing<bool> markTodoList(MarkTodoListParameter markTodoListParameter);
}