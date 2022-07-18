import 'package:flutter/material.dart';
import 'package:radiotest/widgets/radio_button_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Radio',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Radiotest'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            RadioButtonFormField<int>(
              data: const [
                {'value': 1, 'display': 'One'},
                {'value': 2, 'display': 'Two'},
              ],
              titleStyle: const TextStyle(color: Colors.white),
              toggleable: true,
              validator: (val) => val != null ? null : 'something went wrong',
              onSaved: (val) {
                print(val);
              },
              onValueChanged: (val) {
                print(val);
              },
              value: 'value',
              display: 'display',
            ),
            TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState?.save();
                  } else {
                    print('error');
                  }
                },
                child: const Text('test'))
          ],
        ),
      ),
    );
  }
}
