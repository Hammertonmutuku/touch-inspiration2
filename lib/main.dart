import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
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

class EditUser extends StatefulWidget {
  final User user;

  EditUser({required this.user});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _occupationController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _occupationController = TextEditingController(text: widget.user.occupation);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _occupationController,
              decoration: InputDecoration(labelText: 'Occupation'),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedUser = User(
                  id: widget.user.id,
                  name: _nameController.text,
                  email: _emailController.text,
                  occupation: _occupationController.text,
                  bio: _bioController.text,
                );
                StoreProvider.of<AppState>(context).dispatch(EditUserAction(updatedUser));
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
