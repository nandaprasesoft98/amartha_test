import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/change_todo_list_parameter.dart';
import '../entity/change_todo_list_response.dart';
import '../repository/todo_repository.dart';

class ChangeTodoListUseCase {
  final TodoRepository todoRepository;

  ChangeTodoListUseCase({
    required this.todoRepository
  });

  FutureProcessing<LoadDataResult<ChangeTodoListResponse>> execute(ChangeTodoListParameter changeTodoListParameter) {
    return todoRepository.changeTodoList(changeTodoListParameter);
  }
}