import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        fillColor: Color(0xFFF0F1F2),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        hintText: "Search Anything",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
