import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/get_todo_list_parameter.dart';
import '../entity/get_todo_list_response.dart';
import '../repository/todo_repository.dart';

class GetTodoListUseCase {
  final TodoRepository todoRepository;

  GetTodoListUseCase({
    required this.todoRepository
  });

  FutureProcessing<LoadDataResult<GetTodoListResponse>> execute(GetTodoListParameter getTodoListParameter) {
    return todoRepository.getTodoList(getTodoListParameter);
  }
}