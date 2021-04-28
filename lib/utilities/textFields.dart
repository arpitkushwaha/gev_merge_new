import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(IconData icons, String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    prefixIcon: IconButton(
      icon: Icon(icons),
      onPressed: null,
    ),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(15.0),
      ),
      borderSide: BorderSide(color: Colors.white, width: 1.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(15.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(15.0),
      ),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.5,
      ),
    ),
  );
}
