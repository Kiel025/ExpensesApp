import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({
    required this.selectedDate,
    required this.onDateChanged,
    super.key,
  });

  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2022),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Row(
            children: [
              Expanded(
                child: Text(
                  'Data: ${DateFormat('d MMM y').format(selectedDate)}',
                ),
              ),
              TextButton(
                onPressed: () => _showDatePicker(context),
                child: Text(
                  'Selecionar data',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
  }
}
