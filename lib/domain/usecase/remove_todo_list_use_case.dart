import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/remove_todo_list_parameter.dart';
import '../entity/remove_todo_list_response.dart';
import '../repository/todo_repository.dart';

class RemoveTodoListUseCase {
  final TodoRepository todoRepository;

  RemoveTodoListUseCase({
    required this.todoRepository
  });

  FutureProcessing<LoadDataResult<RemoveTodoListResponse>> execute(RemoveTodoListParameter removeTodoListParameter) {
    return todoRepository.removeTodoList(removeTodoListParameter);
  }
}