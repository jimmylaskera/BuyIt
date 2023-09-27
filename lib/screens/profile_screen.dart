import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/user_data.dart';

class ProfileScreen extends StatefulWidget {
   @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User _userSelected = User(id: 'NULL', username: '', password: '');

  @override
  Widget build(BuildContext context) {
    if(_userSelected.id == 'NULL') _userSelected = ModalRoute.of(context)!.settings.arguments as User;

    _openTaskFormModal() {
      final _usernameController = TextEditingController();
      final _passwordController = TextEditingController();
      _usernameController.text = _userSelected.username;

      showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Text('Editar dados de usuário', style: Theme.of(context).textTheme.headlineSmall),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuário',
                    hintText: 'Ex: username123'
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) return;
                    setState(() {
                      _userSelected.username = _usernameController.text;
                      _userSelected.password = _passwordController.text;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Atualizar')
                ),
              ],
            ),
          );
        }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _userSelected);
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Icon(Icons.account_circle, size: 80)
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Text(_userSelected.username, style: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _openTaskFormModal(),
                child: const Text('Editar dados')
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    UserData.currentUser = '';
                  });
                  Navigator.of(context).maybePop();
                },
                child: const Text('Logout')
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: UserData.currentUser == '' ? null : () {
          Navigator.pushNamed(context, '/user/history');
        },
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}