// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:currency_picker/currency_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ScreenAddProduct extends StatefulWidget {
  const ScreenAddProduct({Key? key}) : super(key: key);

  @override
  State<ScreenAddProduct> createState() => _ScreenAddProductState();
}

class _ScreenAddProductState extends State<ScreenAddProduct> {
  final _formKey = GlobalKey<FormState>();
  String currencyCode = 'ISL';
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your product name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your product description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price',
                      hintText: 'Enter your product price',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      // price must be a double
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                buildCurrencyPicker(context),
                const SizedBox(height: 20),
                // todo: add image picker
                OutlinedButton(
                    onPressed: _filePiker, child: const Text('Add Image')),
                // todo: add preference picker

                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCurrencyPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: OutlinedButton(
            onPressed: () {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyCode: true,
                showCurrencyName: true,
                onSelect: (Currency currency) {
                  debugPrint('Select currency: ${currency.code}');
                  _changeCurrency(currency.code);
                },
                currencyFilter: <String>['EUR', 'USD', 'ILS'],
              );
            },
            child: const Text('Select Currency'),
          ),
        ),
        SizedBox(width: 50, child: Center(child: Text(currencyCode))),
      ],
    );
  }

  void _changeCurrency(String currencyCode) {
    setState(() {
      this.currencyCode = currencyCode;
    });
  }

  Future _filePiker() async {
    final result = await FilePicker.platform.pickFiles();
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
