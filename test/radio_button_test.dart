import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radiotest/widgets/radio_button_form_field.dart';

void main() {
  Widget createWidgetUnderTest({
    List<int?>? logOnValue,
    List<int?>? logOnSave,
  }) {
    return MaterialApp(
        title: 'Test',
        home: Scaffold(
          body: RadioButtonFormField<int>(
            data: const [
              {'value': 1, 'display': 'One'},
              {'value': 2, 'display': 'Two'},
            ],
            titleStyle: const TextStyle(color: Colors.white),
            toggleable: true,
            validator: (val) => val != null ? null : 'something went wrong',
            onSaved: (val) {
              if (logOnSave != null) {
                logOnSave.add(val);
              }
            },
            onValueChanged: (val) {
              if (logOnValue != null) {
                logOnValue.add(val);
              }
            },
            value: 'value',
            display: 'display',
          ),
        ));
  }

  testWidgets(
    "title is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
    },
  );

  testWidgets(
    "tile value changed",
    (WidgetTester tester) async {
      final List<int?> logOnValue = <int?>[];
      await tester.pumpWidget(createWidgetUnderTest(logOnValue: logOnValue));
      await tester.tap(find.text('One'));
      expect(logOnValue, equals(<int>[1]));
      logOnValue.clear();
      await tester.tap(find.text('Two'));
      expect(logOnValue, equals(<int>[2]));
    },
  );

  testWidgets(
    "form validation",
    (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>(debugLabel: 'formKey');
      await tester
          .pumpWidget(Form(key: formKey, child: createWidgetUnderTest()));
      await tester.tap(find.text('One'));
      expect(formKey.currentState?.validate(), equals(true));
      await tester.tap(find.text('Two'));
      expect(formKey.currentState?.validate(), equals(true));
      await tester.tap(find.text('Two'));
      expect(formKey.currentState?.validate(), equals(false));
    },
  );

  testWidgets(
    "form onSave changed",
    (WidgetTester tester) async {
      final List<int?> logOnSave = <int?>[];
      final formKey = GlobalKey<FormState>(debugLabel: 'formKey');
      await tester.pumpWidget(Form(
          key: formKey, child: createWidgetUnderTest(logOnSave: logOnSave)));
      await tester.tap(find.text('One'));
      formKey.currentState?.save();
      expect(logOnSave, equals(<int>[1]));
      logOnSave.clear();
      await tester.tap(find.text('Two'));
      formKey.currentState?.save();
      expect(logOnSave, equals(<int>[2]));
      logOnSave.clear();
      await tester.tap(find.text('Two'));
      formKey.currentState?.save();
      expect(logOnSave, equals(<int?>[null]));
    },
  );

  testWidgets(
    "form error",
    (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>(debugLabel: 'formKey');
      await tester
          .pumpWidget(Form(key: formKey, child: createWidgetUnderTest()));
      formKey.currentState?.validate();
      await tester.pump(const Duration(milliseconds: 100));
      expect(formKey.currentState?.validate(), equals(false));
      expect(find.text("something went wrong"), findsOneWidget);
    },
  );
}
