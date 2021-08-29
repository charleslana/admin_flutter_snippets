import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Utils {
  static DateTime toDateTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }
    return timestamp.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    return dateTime.toUtc();
  }

  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.closeSnackBar,
          onPressed: () {},
        ),
      ),
    );
  }

  static StreamTransformer<dynamic, dynamic> transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<T>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> data,
            EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();
          sink.add(objects);
        },
      );
}
