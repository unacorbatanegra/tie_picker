import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore_for_file: avoid_print

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

  void openMiniPicker() async {
    final result = await ModalPicker.miniPick<int>(
      context: context,
      label: 'Mini pick',
      list: List.generate(50, (index) => index),
      item: item,
      toText: (value) => 'Option $value',
    );
    if (result == null) return;
    item = result;
  }

  void openTimePicker() async {
    date = await ModalPicker.timePicker(
      context: context,
      date: date,
    );
  }
}
