import 'package:get/get.dart';

import '../domain/entity/get_todo_list_response.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class TodoController extends BaseGetxController {
  late Rx<LoadDataResultWrapper<GetTodoListResponse>> getTodoListResponseLoadDataResultWrapperRx;
  LoadDataResult<GetTodoListResponse> _getTodoListResponseLoadDataResult = NoLoadDataResult<GetTodoListResponse>();

  TodoController(super.controllerManager) {
    getTodoListResponseLoadDataResultWrapperRx = LoadDataResultWrapper<GetTodoListResponse>(_getTodoListResponseLoadDataResult).obs;
  }

  @override
  void onInitController() {
    _getTodoListResponseLoadDataResult = IsLoadingLoadDataResult<GetTodoListResponse>();
    _updateTodoState();

    _getTodoListResponseLoadDataResult = NoLoadDataResult<GetTodoListResponse>();
    _updateTodoState();
  }

  void _updateTodoState() {
    getTodoListResponseLoadDataResultWrapperRx.value = LoadDataResultWrapper<GetTodoListResponse>(_getTodoListResponseLoadDataResult);
    update();
  }
}