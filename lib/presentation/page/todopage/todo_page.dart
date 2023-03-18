import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../../controller/todo_controller.dart';
import '../../../misc/constant.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/getextended/get_restorable_route_future.dart';
import '../../../misc/manager/controller_manager.dart';
import '../getx_page.dart';
import 'todo_page_controller_mediator_widget.dart';

class TodoPage extends RestorableGetxPage<_TodoPageRestoration> {
  late final ControllerMember<TodoController> _todoController = ControllerMember<TodoController>().addToControllerManager(controllerManager);

  TodoPage({Key? key}) : super(key: key, pageRestorationId: () => "todo-page");

  @override
  void onSetController() {
    _todoController.controller = Injector.locator<TodoPageSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return StatefulTodoControllerMediatorWidget(
      todoController: _todoController.controller
    );
  }
}

class _TodoPageRestoration extends MixableGetxPageRestoration with TodoPageRestorationMixin {
  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();
  }

  @override
  // ignore: unnecessary_overrides
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }
}

mixin TodoPageRestorationMixin on MixableGetxPageRestoration {
  late TodoPageRestorableRouteFuture todoPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    todoPageRestorableRouteFuture = TodoPageRestorableRouteFuture(restorationId: restorationIdWithPageName('todo-page-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    todoPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    todoPageRestorableRouteFuture.dispose();
  }
}

class TodoPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => TodoPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(TodoPage()));
}

class TodoPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  TodoPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        if (arguments is String) {
          if (arguments == Constant.restorableRouteFuturePushAndRemoveUntil) {
            return navigator.restorablePushAndRemoveUntil(_pageRouteBuilder, (route) => false, arguments: arguments);
          } else {
            return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
          }
        } else {
          return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
        }
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(TodoPageGetPageBuilderAssistant()),
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return _getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => _getRoute(arguments) != null;

  @override
  void presentIfCheckIsPassed([Object? arguments]) => _pageRoute.present(arguments);

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    restorator.registerForRestoration(_pageRoute, restorationId);
  }

  @override
  void dispose() {
    _pageRoute.dispose();
  }
}