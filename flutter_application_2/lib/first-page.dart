// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import './widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the label and switch here
              //as children of the row.
              const Text('Enable Buttons'),
              Switch(
                  value: enabled,
                  onChanged: (bool onChangedValue) {
                    print('onChangedValue is $onChangedValue');
                    enabled = onChangedValue;
                    setState(() {
                      if (enabled) {
                        timesClicked = 0;
                        msg1 = 'Click Me';
                        print('_enabled is true');
                      } else {
                        msg1 = 'Disabled';
                        print('enabled is false');
                      }
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked++;
                      msg1 = 'Clicked $timesClicked';
                      print('clicked $msg1 ');
                    });
                  },
                  child: Text(msg1),
                ),
              ),
              const SizedBox(
                height: 5,
                width: 10,
              ),
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked = 0;
                      msg1 = 'Clicked $timesClicked';
                      print('Counter was reset');
                    });
                  },
                  child: Text('Reset'),
                ),
              ),
            ],
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: textEditingController,
                    onChanged: (value) {
                      print(value);
                    },
                    onFieldSubmitted: (text) {
                      print('Submitted First Name Text = $text');
                      if (formKey.currentState!.validate()) {
                        print('the first name input is now valid');
                      }
                    },
                    validator: (input) {
                      return input!.isEmpty ? 'min 1 char please' : null;
                    },
                    onSaved: (input) {
                      print('onSaved first name = $input');
                      firstName = input;
                    },
                    maxLength: 20,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.hourglass_top),
                      hintText: 'first name',
                      labelText: 'first name',
                      helperText: 'min 1, max 20',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SnackbarButton(),
                      ),
                    ],
                  ),
                  //TODO: Build the text form field here as the first
                  // child of the column.
                  // Include as the second child of the column
                  // a submit button that will show a
                  // snackbar with the "firstName" if validation
                  // is satisfied.
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SnackbarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Build the submit button and snackbar here by
    //replacing this Text widget with what is necessary.
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          textEditingController.clear();

          String message = 'Hey There, your name is $firstName!';

          dynamic snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.favorite,
                  // color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(message),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    print(message);
                  },
                  child: const Text(
                    'Click Me',
                  ),
                ),
              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text('Submit'),
    );
  }
}
