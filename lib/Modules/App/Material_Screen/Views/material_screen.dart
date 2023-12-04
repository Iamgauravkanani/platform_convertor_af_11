// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platform_convertor_11/Modules/App/Material_Screen/Providers/Date_Picker_Provider/date_picker_provider.dart';
import 'package:platform_convertor_11/Modules/utils/Platform_Provider/Provider/platform_provider.dart';
import 'package:provider/provider.dart';

class Material_Screen extends StatelessWidget {
  Material_Screen({super.key});
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        leading: const Icon(Icons.home),
        actions: [
          Switch(
              value: Provider.of<PlatformProvider>(context, listen: true)
                  .platform
                  .isIos,
              onChanged: (val) {
                Provider.of<PlatformProvider>(context, listen: false)
                    .changePlatform();
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            TextButton(
                onPressed: () {
                  scaffoldKey.currentState?.showBottomSheet(
                    (context) => Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.camera),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.photo),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text("Show Bottom Sheet")),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    height: 200,
                    width: double.infinity,
                  ),
                );
              },
              child: const Text("Show Modal BottomSheet"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2050),
                    );

                    Provider.of<DatePickerProvider>(context, listen: false)
                        .pickDate(datetime: pickedDate!);
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    size: 35,
                  ),
                ),
                Text(
                    "${Provider.of<DatePickerProvider>(context, listen: true).datePicker.date.day}/"
                    "${Provider.of<DatePickerProvider>(context, listen: true).datePicker.date.month}/"
                    "${Provider.of<DatePickerProvider>(context, listen: true).datePicker.date.year}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
