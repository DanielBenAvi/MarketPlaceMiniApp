import 'package:flutter/material.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/boundaries/user_boundary.dart';
import 'package:marketplace/other/validator.dart';
import 'package:marketplace/singleton_user.dart';
import 'dart:typed_data';
// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_storage/firebase_storage.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({Key? key}) : super(key: key);

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? downloadURL;

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
                      onPressed: _filePiker, child: const Text('Add Image')),
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
    user.avatar = downloadURL;
    // - update singleton user

    if (_formKey.currentState!.validate()) {
      _moveToNextScreen();
    }
  }

  void _moveToNextScreen() {
    Navigator.pushNamed(context, '/register_user_details');
  }

  Future _filePiker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg'],
    );
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
    Uint8List? uploadFile = result.files.single.bytes;
    final path = 'files/${pickedFile!.name}';

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putData(uploadFile!);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      downloadURL = urlDownload;
    });
    debugPrint('Download-Link: $urlDownload');
  }
}
