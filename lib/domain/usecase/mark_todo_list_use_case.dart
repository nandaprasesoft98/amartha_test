import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/mark_todo_list_parameter.dart';
import '../entity/mark_todo_list_response.dart';
import '../repository/todo_repository.dart';

class MarkTodoListUseCase {
  final TodoRepository todoRepository;

  MarkTodoListUseCase({
    required this.todoRepository
  });

  FutureProcessing<LoadDataResult<MarkTodoListResponse>> execute(MarkTodoListParameter markTodoListParameter) {
    return todoRepository.markTodoList(markTodoListParameter);
  }
}