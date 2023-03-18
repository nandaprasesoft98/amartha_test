import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/add_todo_list_parameter.dart';
import '../entity/add_todo_list_response.dart';
import '../repository/todo_repository.dart';

class AddTodoListUseCase {
  final TodoRepository todoRepository;

  AddTodoListUseCase({
    required this.todoRepository
  });

  FutureProcessing<LoadDataResult<AddTodoListResponse>> execute(AddTodoListParameter addTodoListParameter) {
    return todoRepository.addTodoList(addTodoListParameter);
  }
}