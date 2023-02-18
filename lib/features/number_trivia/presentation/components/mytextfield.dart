// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTextField extends StatefulWidget {
  final dynamic controller;
  final String hintText;
  final bool obsCureText;

  const MyTextField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.obsCureText});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key:_formKey,
        child: TextFormField(
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          }),
          controller: widget.controller,
          obscureText: widget.obsCureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: widget.hintText,
          ),
        ),
      ),
    );
  }
}
