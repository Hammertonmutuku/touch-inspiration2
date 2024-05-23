import 'package:touch_inspiration2/Models/users.dart';

class AppState {
  final List<User>  users;
  
  AppState({this.users = const[]});

  AppState copyWith({List<User>? users}) {
    return AppState(
      users: users ?? this.users,
    );
  }


}