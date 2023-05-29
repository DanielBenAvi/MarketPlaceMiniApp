import 'package:flutter/material.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/boundaries/user_boundary.dart';
import 'package:marketplace/other/validator.dart';
import 'package:marketplace/singleton_user.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({Key? key}) : super(key: key);

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => Validator().isValidEmail(value!)
                          ? null
                          : 'Please enter a valid email'),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        Validator().isNotEmpty(value!) ? null : 'Required',
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: _continue,
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _continue() async {
    // create new userBoundary
    NewUserBoundary newUserBoundary = NewUserBoundary(
        email: _emailController.text,
        role: 'SUPERAPP_USER',
        username: _usernameController.text,
        avatar: 'demo_avatar');
    // call api to register user
    bool? flag = await UserApi().postUser(newUserBoundary.toJson());
    if (flag == null) {
      // if null, show error
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error registering user'),
        ),
      );
      return;
    }
    // if successful, update singleton user
    SingletonUser user = SingletonUser.instance;
    user.email = _emailController.text;
    user.username = _usernameController.text;
    user.role = 'SUPERAPP_USER';
    user.avatar = 'demo_avatar';
    // - update singleton user

    if (_formKey.currentState!.validate()) {
      _moveToNextScreen();
    }
  }

  void _moveToNextScreen() {
    Navigator.pushNamed(context, '/register_user_details');
  }
}
