import 'package:amartha_test/data/datasource/tododatasource/todo_data_source.dart';
import 'package:amartha_test/data/repository/default_todo_repository.dart';
import 'package:amartha_test/domain/entity/add_todo_list_parameter.dart';
import 'package:amartha_test/domain/entity/add_todo_list_response.dart';
import 'package:amartha_test/domain/entity/change_todo_list_parameter.dart';
import 'package:amartha_test/domain/entity/change_todo_list_response.dart';
import 'package:amartha_test/domain/entity/get_todo_list_parameter.dart';
import 'package:amartha_test/domain/entity/get_todo_list_response.dart';
import 'package:amartha_test/domain/entity/mark_todo_list_parameter.dart';
import 'package:amartha_test/domain/entity/mark_todo_list_response.dart';
import 'package:amartha_test/domain/entity/remove_todo_list_parameter.dart';
import 'package:amartha_test/domain/entity/remove_todo_list_response.dart';
import 'package:amartha_test/domain/entity/todo.dart';
import 'package:amartha_test/domain/entity/todo_mutable_wrapper.dart';
import 'package:amartha_test/domain/repository/todo_repository.dart';
import 'package:amartha_test/domain/usecase/add_todo_list_use_case.dart';
import 'package:amartha_test/domain/usecase/change_todo_list_use_case.dart';
import 'package:amartha_test/domain/usecase/get_todo_list_use_case.dart';
import 'package:amartha_test/domain/usecase/mark_todo_list_use_case.dart';
import 'package:amartha_test/domain/usecase/remove_todo_list_use_case.dart';
import 'package:amartha_test/misc/ext/load_data_result_ext.dart';
import 'package:amartha_test/misc/load_data_result.dart';
import 'package:amartha_test/misc/processing/dummy_future_processing.dart';
import 'package:amartha_test/misc/processing/futureprocessingcancellation/default_future_processing_cancellation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_list_usecase_test.mocks.dart';

@GenerateMocks([TodoDataSource])
void main() {
  group('Todo List Use Case Test', () {
    late List<TodoMutableWrapper> dummyTodoList;
    late TodoDataSource todoDataSource;
    late TodoRepository todoRepository;

    List<TodoMutableWrapper> generateTodoDummyList() {
      return [
        TodoMutableWrapper(
          todo: Todo(
            id: "1",
            description: "Todo 1",
            isMarked: false
          ),
        ),
        TodoMutableWrapper(
          todo: Todo(
            id: "2",
            description: "Todo 2",
            isMarked: false
          ),
        ),
        TodoMutableWrapper(
          todo: Todo(
            id: "3",
            description: "Todo 3",
            isMarked: false
          ),
        ),
        TodoMutableWrapper(
          todo: Todo(
            id: "4",
            description: "Todo 4",
            isMarked: false
          ),
        ),
        TodoMutableWrapper(
          todo: Todo(
            id: "5",
            description: "Todo 5",
            isMarked: false
          ),
        )
      ];
    }

    DefaultFutureProcessingCancellation generateDefaultFutureProcessingCancellation() {
      return DefaultFutureProcessingCancellation();
    }

    setUp(() {
      dummyTodoList = generateTodoDummyList();
      todoDataSource = MockTodoDataSource();
      todoRepository = DefaultTodoRepository(todoDataSource: todoDataSource);
    });

    test('Get Todo List Use Case', () async {
      GetTodoListParameter getTodoListParameter = GetTodoListParameter();
      when(todoDataSource.getTodoList(getTodoListParameter)).thenReturn(
        DummyFutureProcessing<List<Todo>>((cancelToken) async {
          return dummyTodoList.map((todoMutableWrapper) => todoMutableWrapper.todo).toList();
        })
      );
      GetTodoListUseCase getTodoListUseCase = GetTodoListUseCase(todoRepository: todoRepository);
      LoadDataResult<GetTodoListResponse> todoListLoadDataResult = await getTodoListUseCase.execute(getTodoListParameter).future(
        parameter: generateDefaultFutureProcessingCancellation()
      );
      expect(todoListLoadDataResult.isSuccess, true);
      GetTodoListResponse getTodoListResponse = todoListLoadDataResult.resultIfSuccess!;
      List<Todo> todoList = getTodoListResponse.todoList;
      expect(todoList.length, 5);
    });

    test('Add Todo List Use Case', () async {
      AddTodoListParameter addTodoListParameter = AddTodoListParameter(description: "Todo 6");
      Todo getExpectedTodo() => Todo(
        id: "6",
        description: "Todo 6",
        isMarked: false
      );
      when(todoDataSource.addTodoList(addTodoListParameter)).thenReturn(
        DummyFutureProcessing<bool>((cancelToken) async {
          dummyTodoList.add(TodoMutableWrapper(todo: getExpectedTodo()));
          return true;
        })
      );
      AddTodoListUseCase addTodoListUseCase = AddTodoListUseCase(todoRepository: todoRepository);
      LoadDataResult<AddTodoListResponse> todoListLoadDataResult = await addTodoListUseCase.execute(addTodoListParameter).future(
        parameter: generateDefaultFutureProcessingCancellation()
      );
      expect(todoListLoadDataResult.isSuccess, true);
      expect(dummyTodoList.length, 6);
      expect(dummyTodoList.last.todo, getExpectedTodo());
    });

    test('Change Todo List Use Case', () async {
      ChangeTodoListParameter changeTodoListParameter = ChangeTodoListParameter(
        todoId: "5",
        description: "Changed Todo 5",
        isMarked: true
      );
      Todo getExpectedTodo() => Todo(
        id: changeTodoListParameter.todoId,
        description: changeTodoListParameter.description,
        isMarked: changeTodoListParameter.isMarked
      );
      TodoMutableWrapper getTodoMutableWrapper() => dummyTodoList.where((todoMutableWrapper) => todoMutableWrapper.todo.id == changeTodoListParameter.todoId).first;
      Todo getTodo() => getTodoMutableWrapper().todo;
      when(todoDataSource.changeTodoList(changeTodoListParameter)).thenReturn(
        DummyFutureProcessing<bool>((cancelToken) async {
          TodoMutableWrapper todoMutableWrapper = getTodoMutableWrapper();
          Todo changingTodo = todoMutableWrapper.todo.copy(
            description: changeTodoListParameter.description,
            isMarked: changeTodoListParameter.isMarked
          );
          todoMutableWrapper.todo = changingTodo;
          return true;
        })
      );
      ChangeTodoListUseCase changeTodoListUseCase = ChangeTodoListUseCase(todoRepository: todoRepository);
      LoadDataResult<ChangeTodoListResponse> changeTodoListLoadDataResult = await changeTodoListUseCase.execute(changeTodoListParameter).future(
        parameter: generateDefaultFutureProcessingCancellation()
      );
      expect(changeTodoListLoadDataResult.isSuccess, true);
      expect(dummyTodoList.length, 5);
      expect(getTodo(), getExpectedTodo());
    });

    test('Remove Todo List Use Case', () async {
      RemoveTodoListParameter removeTodoListParameter = RemoveTodoListParameter(todoId: "5");
      when(todoDataSource.removeTodoList(removeTodoListParameter)).thenReturn(
        DummyFutureProcessing<bool>((cancelToken) async {
          dummyTodoList.removeWhere((todoMutableWrapper) => todoMutableWrapper.todo.id == removeTodoListParameter.todoId);
          return true;
        })
      );
      RemoveTodoListUseCase removeTodoListUseCase = RemoveTodoListUseCase(todoRepository: todoRepository);
      LoadDataResult<RemoveTodoListResponse> removeTodoListLoadDataResult = await removeTodoListUseCase.execute(removeTodoListParameter).future(
        parameter: generateDefaultFutureProcessingCancellation()
      );
      expect(removeTodoListLoadDataResult.isSuccess, true);
      expect(dummyTodoList.length, 4);
    });

    test('Mark Todo List Use Case', () async {
      MarkTodoListParameter markTodoListParameter = MarkTodoListParameter(todoId: "5");
      TodoMutableWrapper getTodoMutableWrapper() => dummyTodoList.where((todoMutableWrapper) => todoMutableWrapper.todo.id == markTodoListParameter.todoId).first;
      Todo getTodo() => getTodoMutableWrapper().todo;
      Todo lastTodo = getTodo();
      when(todoDataSource.markTodoList(markTodoListParameter)).thenReturn(
        DummyFutureProcessing<bool>((cancelToken) async {
          TodoMutableWrapper todoMutableWrapper = getTodoMutableWrapper();
          Todo changingTodo = lastTodo.copy(
            isMarked: !lastTodo.isMarked
          );
          todoMutableWrapper.todo = changingTodo;
          return true;
        })
      );
      MarkTodoListUseCase markTodoListUseCase = MarkTodoListUseCase(todoRepository: todoRepository);
      LoadDataResult<MarkTodoListResponse> todoListLoadDataResult = await markTodoListUseCase.execute(markTodoListParameter).future(
        parameter: generateDefaultFutureProcessingCancellation()
      );
      expect(todoListLoadDataResult.isSuccess, true);
      expect(dummyTodoList.length, 5);
      expect(getTodo().isMarked, !lastTodo.isMarked);
    });
  });
}