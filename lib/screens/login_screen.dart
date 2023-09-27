import 'package:flutter/material.dart';
import 'dart:math';

import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  late List<User> _users;

  @override
  Widget build(BuildContext context) {
    _users = ModalRoute.of(context)!.settings.arguments as List<User>;

    final userController = TextEditingController();
    final passController = TextEditingController();

    _openTaskFormModal() {
      final _usernameController = TextEditingController();
      final _passwordController = TextEditingController();

      showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Text('Cadastro de usuário', style: Theme.of(context).textTheme.headlineSmall),
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
                    User u = User(id: Random().nextInt(9999).toString(), username: _usernameController.text, password: _passwordController.text);
                    _users.add(u);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cadastrar')
                ),
              ],
            ),
          );
        }
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Image(image: AssetImage('assets/logo_v.png')),
              const SizedBox(height: 20),
              TextFormField(
                controller: userController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome de usuário',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: (() {
                  String userFound = '';
                  const snackBar = SnackBar(
                    content: Text('Usuário ou senha não encontrados'),
                  );

                  for (var u in _users) {
                    if(u.username == userController.text && u.password == passController.text) {
                      userFound = u.id;
                      break;
                    }
                  }

                  if (userFound != '') {
                    Navigator.pop(context, userFound);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    userController.clear();
                    passController.clear();
                  }
                }),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() => _openTaskFormModal()),
                child: const Text('Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}