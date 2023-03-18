import '../../../domain/entity/add_todo_list_parameter.dart';
import '../../../domain/entity/change_todo_list_parameter.dart';
import '../../../domain/entity/get_todo_list_parameter.dart';
import '../../../domain/entity/mark_todo_list_parameter.dart';
import '../../../domain/entity/remove_todo_list_parameter.dart';
import '../../../domain/entity/todo.dart';
import '../../../misc/processing/dummy_future_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'todo_data_source.dart';

class DefaultTodoDataSource implements TodoDataSource {
  @override
  FutureProcessing<List<Todo>> getTodoList(GetTodoListParameter getTodoListParameter) {
    return DummyFutureProcessing<List<Todo>>((cancelToken) async {
      return [];
    });
  }

  @override
  FutureProcessing<bool> addTodoList(AddTodoListParameter addTodoListParameter) {
    return DummyFutureProcessing<bool>((cancelToken) async {
      return true;
    });
  }

  @override
  FutureProcessing<bool> changeTodoList(ChangeTodoListParameter changeTodoListParameter) {
    return DummyFutureProcessing<bool>((cancelToken) async {
      return true;
    });
  }

  @override
  FutureProcessing<bool> removeTodoList(RemoveTodoListParameter deleteTodoListParameter) {
    return DummyFutureProcessing<bool>((cancelToken) async {
      return true;
    });
  }

  @override
  FutureProcessing<bool> markTodoList(MarkTodoListParameter markTodoListParameter) {
    return DummyFutureProcessing<bool>((cancelToken) async {
      return true;
    });
  }
}