import 'package:flutter/material.dart';

class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.arrow_back_ios,
            color: color.onSurface,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add,
              color: color.onSurface,
              size: 27,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Savings Goals",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
