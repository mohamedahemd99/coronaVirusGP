import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_infected_helper/core/model/vaccine_user.dart';
import 'package:covid_infected_helper/ui/screens/layout/layout_screen.dart';
import 'package:covid_infected_helper/ui/screens/notifications/app_notification.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class TimeVacineScreen extends StatefulWidget {
  const TimeVacineScreen({Key? key, this.user}) : super(key: key);
  final VaccineUser? user;

  @override
  State<TimeVacineScreen> createState() => _TimeVacineScreenState();
}

class _TimeVacineScreenState extends State<TimeVacineScreen> {
  String? savedDateString;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg,
      appBar: _buildHeader(),
      body: _buildBody(),
    );
  }

  _buildHeader() {
    return AppBar(
      flexibleSpace: Container(decoration: bgGradient),
      title: const Text("Time of Vaccine"),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _buildDateTime(),
          const SizedBox(height: 40),
          _buildSaveButton()
        ],
      ),
    );
  }

  _buildDateTime() {
    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
      icon: Icon(Icons.event),
      dateLabelText: 'Date',
      timeLabelText: "Hour",
      onChanged: (val) {
        savedDateString = val;
        setState(() {});
      },
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) {
        savedDateString = val;
        setState(() {});
      },
    );
  }

  _buildSaveButton() {
    return !isLoading
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkResponse(
              onTap: () {
                setState(() {
                  isLoading = true;
                });
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.user!.uid)
                    .update({
                  "dataOfVaccine": savedDateString,
                }).then((value) {
                  DateTime tempDate = DateTime.parse(savedDateString!);
                  // DateFormat("yyyy-MM-dd  HH:mm:ss").parse(savedDateString!);
                  print(tempDate);
                  //before day
                  AppNotification.zonedScheduleNotification(
                      id: 1,
                      title: "Time of Vaccine",
                      body: "We think that the vaccine is due tomorrow",
                      payload: "hello",
                      dateTime: tempDate.subtract(const Duration(days: 1)));
                  //after days//
                  AppNotification.zonedScheduleNotification(
                      id: 2,
                      title: "Time of Vaccine",
                      body:
                          "We are confident about your condition after taking the vaccine",
                      payload: jsonEncode(widget.user),
                      dateTime: tempDate.add(const Duration(days: 1)));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LayOutScreen(
                          user: widget.user,
                        ),
                      ));
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: mainColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Save',
                    style: titleStyle.copyWith(color: txtButtons),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
