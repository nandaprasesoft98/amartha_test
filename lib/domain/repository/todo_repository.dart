import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/add_todo_list_parameter.dart';
import '../entity/add_todo_list_response.dart';
import '../entity/change_todo_list_parameter.dart';
import '../entity/change_todo_list_response.dart';
import '../entity/get_todo_list_parameter.dart';
import '../entity/get_todo_list_response.dart';
import '../entity/mark_todo_list_parameter.dart';
import '../entity/mark_todo_list_response.dart';
import '../entity/remove_todo_list_parameter.dart';
import '../entity/remove_todo_list_response.dart';

abstract class TodoRepository {
  FutureProcessing<LoadDataResult<GetTodoListResponse>> getTodoList(GetTodoListParameter getTodoListParameter);
  FutureProcessing<LoadDataResult<AddTodoListResponse>> addTodoList(AddTodoListParameter addTodoListParameter);
  FutureProcessing<LoadDataResult<ChangeTodoListResponse>> changeTodoList(ChangeTodoListParameter changeTodoListParameter);
  FutureProcessing<LoadDataResult<RemoveTodoListResponse>> removeTodoList(RemoveTodoListParameter removeTodoListParameter);
  FutureProcessing<LoadDataResult<MarkTodoListResponse>> markTodoList(MarkTodoListParameter markTodoListParameter);
}