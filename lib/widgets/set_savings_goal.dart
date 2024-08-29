// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: null,
            // ... (your ElevatedButton styling)

            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                builder: (context) {
                  return const SizedBox(
                    // <-- SizedBox for fixed width
                    width: 300, // Set your desired width
                    child: SetSavingsGoal(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget for Setting a Savings Goal
class SetSavingsGoal extends StatefulWidget {
  const SetSavingsGoal({super.key});

  @override
  State<SetSavingsGoal> createState() => _SetSavingsGoalState();
}

class _SetSavingsGoalState extends State<SetSavingsGoal> {
  // Track which section to show
  String? _activeSection; // "custom", "setTime", or null (initial)

  final TextEditingController _goalNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      // Padding for better visual spacing
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Set a New Savings Goal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Show buttons only if no section is active
          if (_activeSection == null)
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(color.surface),
                    backgroundColor: WidgetStateProperty.all(color.primary),
                    shape: WidgetStateProperty.all(
                      const StadiumBorder(),
                    ),
                  ),
                  onPressed: () => setState(() => _activeSection = 'custom'),
                  child: const Text('Custom Goal'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(color.surface),
                    backgroundColor: WidgetStateProperty.all(color.primary),
                    shape: WidgetStateProperty.all(
                      const StadiumBorder(),
                    ),
                  ),
                  onPressed: () => setState(() => _activeSection = 'setTime'),
                  child: const Text('SetTime Goal'),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: () => setState(() => _activeSection = null),
              child: const Text('Back'),
            ),

          const SizedBox(height: 20),

          // Conditional rendering based on active section
          if (_activeSection == 'custom')
            _buildCustomGoalForm()
          else if (_activeSection == 'setTime')
            _buildSetTimeOptions()
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  // Widget for SetTime options
  Widget _buildSetTimeOptions() {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(color.surface),
            backgroundColor: WidgetStateProperty.all(color.primary),
            shape: WidgetStateProperty.all(
              const StadiumBorder(),
            ),
          ),
          onPressed: () {
            // Process 3-month SetTime goal
            Navigator.pop(context);
          },
          child: const Text('3 Months'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(color.surface),
            backgroundColor: WidgetStateProperty.all(color.primary),
            shape: WidgetStateProperty.all(
              const StadiumBorder(),
            ),
          ),
          onPressed: () {
            // Process 6-month SetTime goal
            Navigator.pop(context);
          },
          child: const Text('6 Months'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(color.surface),
            backgroundColor: WidgetStateProperty.all(color.primary),
            shape: WidgetStateProperty.all(
              const StadiumBorder(),
            ),
          ),
          onPressed: () {
            // Process 12-month SetTime goal
            Navigator.pop(context);
          },
          child: const Text('12 Months'),
        ),
      ],
    );
  }

  // Widget for custom goal form
  Widget _buildCustomGoalForm() {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      children: [
        TextField(
          controller: _goalNameController,
          decoration: const InputDecoration(labelText: 'Goal Name'),
        ),
        TextField(
          controller: _amountController,
          decoration: const InputDecoration(labelText: 'Target Amount'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(color.surface),
            backgroundColor: WidgetStateProperty.all(color.primary),
            shape: WidgetStateProperty.all(
              const StadiumBorder(),
            ),
          ),
          onPressed: () {
            // Get data from custom goal form
            String goalName = _goalNameController.text;
            String amount = _amountController.text;
            // Process custom goal data

            Navigator.pop(context);
          },
          child: const Text('Create Goal'),
        ),
      ],
    );
  }
}
