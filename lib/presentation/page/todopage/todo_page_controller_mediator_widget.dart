import 'package:flutter/material.dart';

import '../../../controller/todo_controller.dart';
import '../../../domain/entity/get_todo_list_response.dart';
import '../../widget/rx_consumer.dart';

class StatefulTodoControllerMediatorWidget extends StatefulWidget {
  final TodoController todoController;

  const StatefulTodoControllerMediatorWidget({
    super.key,
    required this.todoController
  });

  @override
  State<StatefulTodoControllerMediatorWidget> createState() => StatefulTodoControllerMediatorWidgetState();
}

class StatefulTodoControllerMediatorWidgetState extends State<StatefulTodoControllerMediatorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RxConsumer<GetTodoListResponse>(
      rxValue: todoController.,
    )
  }
}