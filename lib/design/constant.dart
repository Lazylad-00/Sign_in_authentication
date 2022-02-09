import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.grey,
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
        width: 0.0,
      ),
      borderRadius: BorderRadius.circular(15.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 3.0,
      ),
      borderRadius: BorderRadius.circular(15.0)),
);
