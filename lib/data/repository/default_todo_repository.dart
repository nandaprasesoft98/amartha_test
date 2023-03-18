import '../../domain/entity/add_todo_list_parameter.dart';
import '../../domain/entity/add_todo_list_response.dart';
import '../../domain/entity/change_todo_list_parameter.dart';
import '../../domain/entity/change_todo_list_response.dart';
import '../../domain/entity/get_todo_list_parameter.dart';
import '../../domain/entity/get_todo_list_response.dart';
import '../../domain/entity/mark_todo_list_parameter.dart';
import '../../domain/entity/mark_todo_list_response.dart';
import '../../domain/entity/remove_todo_list_parameter.dart';
import '../../domain/entity/remove_todo_list_response.dart';
import '../../domain/repository/todo_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/tododatasource/todo_data_source.dart';

class DefaultTodoRepository implements TodoRepository {
  final TodoDataSource todoDataSource;

  DefaultTodoRepository({
    required this.todoDataSource
  });

  @override
  FutureProcessing<LoadDataResult<AddTodoListResponse>> addTodoList(AddTodoListParameter addTodoListParameter) {
    return todoDataSource.addTodoList(addTodoListParameter).mapToLoadDataResult(
      onMapToLoadDataResult: (value) => AddTodoListResponse()
    );
  }

  @override
  FutureProcessing<LoadDataResult<ChangeTodoListResponse>> changeTodoList(ChangeTodoListParameter changeTodoListParameter) {
    return todoDataSource.changeTodoList(changeTodoListParameter).mapToLoadDataResult(
      onMapToLoadDataResult: (value) => ChangeTodoListResponse()
    );
  }

  @override
  FutureProcessing<LoadDataResult<GetTodoListResponse>> getTodoList(GetTodoListParameter getTodoListParameter) {
    return todoDataSource.getTodoList(getTodoListParameter).mapToLoadDataResult(
      onMapToLoadDataResult: (value) => GetTodoListResponse(todoList: value)
    );
  }

  @override
  FutureProcessing<LoadDataResult<MarkTodoListResponse>> markTodoList(MarkTodoListParameter markTodoListParameter) {
    return todoDataSource.markTodoList(markTodoListParameter).mapToLoadDataResult(
      onMapToLoadDataResult: (value) => MarkTodoListResponse()
    );
  }

  @override
  FutureProcessing<LoadDataResult<RemoveTodoListResponse>> removeTodoList(RemoveTodoListParameter removeTodoListParameter) {
    return todoDataSource.removeTodoList(removeTodoListParameter).mapToLoadDataResult(
      onMapToLoadDataResult: (value) => RemoveTodoListResponse()
    );
  }
}