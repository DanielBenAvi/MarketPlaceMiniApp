import 'package:flutter/material.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/other/item_object.dart';
import 'package:marketplace/other/preferences.dart';
import 'package:marketplace/other/validator.dart';
import 'package:marketplace/widgets/multi_select_dialog.dart';

class ScreenRegisterUserDetails extends StatefulWidget {
  const ScreenRegisterUserDetails({super.key});

  @override
  State<ScreenRegisterUserDetails> createState() =>
      _ScreenRegisterUserDetailsState();
}

Future _updateUserRole() async {
  await UserApi().updateRole('SUPERAPP_USER');
}

class _ScreenRegisterUserDetailsState extends State<ScreenRegisterUserDetails> {
  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerPhoneNumber = TextEditingController();
  List<ItemObject> _selectedPreferences = [];
  final _formKey = GlobalKey<FormState>();
  // init state
  @override
  void initState() {
    super.initState();
    _updateUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User Details'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            onChanged: () => _formKey.currentState!.validate(),
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _textFieldControllerName,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validator().isNotEmpty(value!)
                      ? null
                      : 'Please enter your full name',
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _textFieldControllerPhoneNumber,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validator().isNotEmpty(value!)
                      ? null
                      : 'Please enter your phone number',
                ),
                const SizedBox(height: 20),
                MultiSelect(
                  "Preferences",
                  "Preferences",
                  Preferences().getPreferences(),
                  onMultiSelectConfirm: (List<ItemObject> results) {
                    _selectedPreferences = results;
                  },
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: _continue, child: const Text('Continue')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _continue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await UserApi().postUserDetails(
        _textFieldControllerName.text,
        _textFieldControllerPhoneNumber.text,
        _selectedPreferences.map((e) => e.name).toList());

    _login();
  }

  void _login() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }
}
