// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tie_picker/tie_picker.dart';

void main() {
  runApp(
    MaterialApp(
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C6EA0),
          brightness: Brightness.light,
        ),
      ),
      supportedLocales: const [
        Locale('es', 'AR'),
        ...TiePickerLocalizations.supportedLocales
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        TiePickerLocalizations.delegate
      ],
      home: const MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? date;
  void openDatePicker() async {
    date = await ModalPicker.datePicker(
      context: context,
      date: date,
      mode: CalendarMode.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tie picker')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: openDatePicker,
                child: const Text('Open date picker'),
              ),
              CupertinoButton(
                onPressed: openModalPicker,
                child: const Text('Open Modal picker'),
              ),
              CupertinoButton(
                onPressed: openMiniPicker,
                child: const Text('Open Mini picker'),
              ),
              CupertinoButton(
                onPressed: openTimePicker,
                child: const Text('Open time picker'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? item = 0;
  void openModalPicker() async {
    final result = await ModalPicker.modalPick<int>(
      context: context,
      label: 'Modal pick',
      list: List.generate(50, (index) => index),
      item: item,
      toText: (value) => 'Option $value',
    );
    if (result == null) return;
    item = result;
  }

  MyClass? data;

  void openMiniPicker() async {
    final result = await ModalPicker.miniPick<MyClass>(
      context: context,
      label: 'Mini pick',
      list: List.generate(
        50,
        (index) => MyClass(id: index, value: "Option $index"),
      ),
      item: data,
      toText: (value) => 'Option $value',
    );
    if (result == null) return;
    data = result;
  }

  void openTimePicker() async {
    date = await ModalPicker.timePicker(
      context: context,
      date: date,
    );
  }
}

class MyClass {
  final int id;
  final String value;

  MyClass({
    required this.id,
    required this.value,
  });

  @override
  bool operator ==(covariant MyClass other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
