import 'package:flutter/material.dart';
import 'package:save_easy/models/user.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/widgets/set_savings_goal.dart';

class Savings extends StatefulWidget {
  const Savings({super.key, required this.user});
  final User user;
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Homepage();
                },
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: color.onSurface,
            size: 20,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const StadiumBorder()),
              backgroundColor: WidgetStateProperty.all(
                color.primary,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, maxWidth: double.infinity),
                context: context,
                isScrollControlled:
                    true, // Allow the sheet to expand to full height

                shape: const RoundedRectangleBorder(
                  // Optional: Customize sheet shape

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                builder: (context) {
                  return SetSavingsGoal(
                    user: widget.user,
                  );
                },
              );
            },
            child: Icon(
              Icons.add,
              color: color.surface,
              size: 27,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
        centerTitle: true,
        title: Text(
          "Saving Goals",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: ListView(
          children: [
            SavingGoalCard(
              cardColor: color.secondary,
              itemLabel: 'Iphone 13 Mini',
              savingsProgressIndicator: '\$300 of \$699',
              percentageProgressIndicator: 0.5,
              daysLeft: "14 days left",
              cardTextColor: color.surface,
            ),
            const SizedBox(
              height: 10,
            ),
            SavingGoalCard(
              cardColor: color.secondaryFixed,
              itemLabel: "Macbook Pro M1",
              savingsProgressIndicator: "\$300 of \$1,499",
              percentageProgressIndicator: 0.3,
              daysLeft: "14 days left",
              cardTextColor: color.onSurface,
            ),
            const SizedBox(
              height: 10,
            ),
            SavingGoalCard(
              cardColor: color.primaryFixed,
              itemLabel: 'School Fees',
              savingsProgressIndicator: '\$10,000 of \$20,000',
              percentageProgressIndicator: 0.9,
              daysLeft: "30 days left",
              cardTextColor: color.onSurface,
            ),
            const SizedBox(
              height: 10,
            ),
            SavingGoalCard(
              cardColor: color.primary,
              itemLabel: 'Capital',
              savingsProgressIndicator: '\$65,000 of \$30,500',
              percentageProgressIndicator: 0.9,
              daysLeft: "60 days left",
              cardTextColor: color.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

class SavingGoalCard extends StatelessWidget {
  const SavingGoalCard({
    super.key,
    required this.cardColor,
    required this.itemLabel,
    required this.savingsProgressIndicator,
    required this.percentageProgressIndicator,
    required this.daysLeft,
    required this.cardTextColor,
  });

  final Color cardColor;
  final String itemLabel;
  final String savingsProgressIndicator;
  final double percentageProgressIndicator;
  final String daysLeft;
  final Color cardTextColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
          height: 176,
          width: double.infinity,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemLabel,
                    style: TextStyle(
                        fontSize: 18,
                        color: color.surface,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Balance",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: color.surface,
                        ),
                      ),
                      Text(
                        "${(percentageProgressIndicator * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: cardTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(
                    value: percentageProgressIndicator,
                    backgroundColor: color.surface.withOpacity(0.7),
                    minHeight: 5,
                    color: color.onSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        savingsProgressIndicator,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: cardTextColor,
                        ),
                      ),
                      Text(
                        daysLeft,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: cardTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 30),
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          builder: (context) {
                            return const AddSavingsBottomSheet();
                          },
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: color.surface,
                        radius: 16,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.assured_workload_rounded,
                  color: color.onSurface.withOpacity(0.15),
                  size: 120,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddSavingsBottomSheet extends StatefulWidget {
  const AddSavingsBottomSheet({super.key});

  @override
  State<AddSavingsBottomSheet> createState() => _AddSavingsBottomSheetState();
}

class _AddSavingsBottomSheetState extends State<AddSavingsBottomSheet> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Add Savings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Updated Button Design
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const StadiumBorder()),
                backgroundColor: MaterialStateProperty.all(color.primary),
              ),
              onPressed: () {
                // TODO: Implement saving logic here
                // You can access the entered amount using _amountController.text
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: color.surface,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _amountController.dispose();
    super.dispose();
  }
}
