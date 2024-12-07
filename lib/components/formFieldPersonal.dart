import 'package:flutter/material.dart';

class FormFieldPersonal extends StatelessWidget {
  final String label;
  final FocusNode node;
  final bool hide;
  final Function(String) onReturn;
  const FormFieldPersonal({
    super.key,
    required this.label,
    required this.node,
    required this.hide,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    String data = '';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${label}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        TextFormField(
          initialValue: data.toString(),
          obscureText: hide,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(node);
          },
          onSaved: (dataName) => data = dataName ?? '',
          validator: (_dataName) {
            final form = _dataName ?? '';

            if (form.trim().isEmpty) {
              return '${label} é obrigatório';
            }
            print("Os dados ão válidos");
            onReturn(data);
          },
        ),
      ],
    );
  }
}
