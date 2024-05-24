import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:touch_inspiration2/Components/userrlist.dart';
import 'package:touch_inspiration2/Models/app_state.dart';
import 'package:touch_inspiration2/Models/users.dart';
import 'package:touch_inspiration2/Redux/Actions/users_actions.dart';
import 'package:touch_inspiration2/Redux/Middleware.dart/users_middleware.dart';
import 'package:touch_inspiration2/Redux/Reducers/users_reducer.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: appMiddleware(),
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: UserList(),
      ),
    );
  }
}


