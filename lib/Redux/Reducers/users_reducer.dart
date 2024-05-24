

import 'package:touch_inspiration2/Redux/Actions/users_actions.dart';
import 'package:touch_inspiration2/Models/app_state.dart';

AppState  appReducer(AppState state, dynamic action) {
   if (action is FetchUsersSuccessAction) {
    return AppState(users: action.users);
  }else if (action is EditUserAction) {
    final updatedUsers = state.users.map((user) {
      return user.id == action.user.id ? action.user : user;
    }).toList();
    return AppState(users: updatedUsers);
  }
  return state;
}

