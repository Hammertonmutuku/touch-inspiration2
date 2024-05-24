import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:touch_inspiration2/Models/app_state.dart';
import 'package:touch_inspiration2/Models/users.dart';
import 'package:touch_inspiration2/Redux/Actions/users_actions.dart';
import 'package:touch_inspiration2/main.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text('User List')),
      body: StoreConnector<AppState, List<User>>(
        converter: (store) => store.state.users,
        onInit: (store) => store.dispatch(FetchUsersAction()),
        builder: (context, users) {
          return ListView.builder(
            itemCount: users.length,
            
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUser(user: user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
