import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:touch_inspiration2/Models/users.dart';
import 'package:touch_inspiration2/Redux/Actions/users_actions.dart';
import 'dart:convert';

import 'package:touch_inspiration2/Models/app_state.dart';


List<Middleware<AppState>> appMiddleware() {
  return [
    TypedMiddleware<AppState,FetchUsersAction>(_fetchUsers),
    TypedMiddleware<AppState, EditUserAction>(_editUser),
  ];
}

void _fetchUsers(Store<AppState> store, FetchUsersAction action, NextDispatcher next) async {
  final response = await http.get(Uri.parse('https://lionfish-app-qkntx.ondigitalocean.app/api/users/'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    final List<User> users = data.map((json) => User.fromJson(json)).toList();
    store.dispatch(FetchUsersSuccessAction(users));
  }
  next(action);
}

void _editUser(Store<AppState> store, EditUserAction action, NextDispatcher next) async {
  final response = await http.patch(
    Uri.parse('https://lionfish-app-qkntx.ondigitalocean.app/api/user/${action.user.id}'),
    body: json.encode({
      'name': action.user.name,
      'email': action.user.email,
      'occupation': action.user.occupation,
      'bio': action.user.bio,
    }),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    store.dispatch(FetchUsersAction());
  }
  next(action);
}
