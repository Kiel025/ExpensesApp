import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:expenses/components/adaptative_button.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();

  final _valueControler = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final String title = _titleControler.text;
    final double value = double.tryParse(_valueControler.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                onSubmitted: _submitForm,
                controller: _titleControler,
                label: 'Título',
              ),
              AdaptativeTextField(
                onSubmitted: _submitForm,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _valueControler,
                label: 'Valor (R\$)',
              ),
              // new component
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: Text(
                      'Nova transação',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
