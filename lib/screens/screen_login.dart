import 'package:flutter/material.dart';
import 'package:marketplace/api/object_api.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/other/validator.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _textFieldEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // title - Market Place
              const Text(
                'Market Place',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const Text(
                'Login',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              // test field for email
              Form(
                onChanged: () {
                  // validate the form
                  _formKey.currentState!.validate();
                },
                key: _formKey,
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _textFieldEmailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      return Validator().isValidEmail(value!)
                          ? null
                          : 'Please enter a valid email';
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // login button
              ElevatedButton(
                onPressed: _loginButton,
                child: const Text('Login'),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: _screenRegister,
                child: const Text(
                  'Register',
                  // underline the text
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _screenRegister() {
    // pop the current screen
    Navigator.pushNamed(context, '/register');
  }

  Future<void> _loginButton() async {
    // validate the form
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    try {
      await UserApi().getUser(_textFieldEmailController.text);
    } catch (e) {
      throw Exception('User does not exist');
    } finally {
      _textFieldEmailController.clear();
    }

    await ObjectApi().getDemoObject();

    _screenExploreProducts();
  }

  void _screenExploreProducts() {
    // pop all the screens
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushNamed(context, '/explore_products');
  }
}
