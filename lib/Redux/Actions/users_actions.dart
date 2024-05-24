import 'package:touch_inspiration2/Models/users.dart';

class FetchUsersAction {}

class FetchUsersSuccessAction {
  final List<User> users;

  FetchUsersSuccessAction(this.users);

}

class EditUserAction {
  final User user;

  EditUserAction(this.user);
}