import 'package:flutter/material.dart';

class FormFieldPersonal extends StatelessWidget {
  final String label;
  final FocusNode node;
  final bool hide;
  final Function(String) onReturn;
  final String? Function(String?)? validator;

  const FormFieldPersonal({
    super.key,
    required this.label,
    required this.node,
    required this.hide,
    required this.onReturn,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        TextFormField(
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
          onFieldSubmitted: (value) {
            onReturn(value);
            FocusScope.of(context).requestFocus(node);
          },
          onSaved: (value) {
            onReturn(value ?? '');
          },
          validator: validator,
        ),
      ],
    );
  }
}
