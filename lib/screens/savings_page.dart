import 'package:flutter/material.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/screens/set_savings_goal.dart';

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
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                builder: (context) {
                  return const SetSavingsGoal();
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
            CustomSavingsGoalCard(
              cardColor: color.secondary,
              itemLabel: 'Iphone 13 Mini',
              targetAmount: '₵699',
              currentAmount: '₵699',
              percentageProgressIndicator: 1.0,
              cardTextColor: color.surface,
            ),
            const SizedBox(
              height: 10,
            ),
            SetTimeSavingsGoalCard(
              cardColor: color.tertiary,
              setTimeGoal: '1 Month',
              currentAmount: '₵700',
              percentageProgressIndicator: 0.0,
              daysLeft: '30 days left',
              cardTextColor: color.onSurface,
              isTimeUp: false,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSavingsGoalCard(
              cardColor: color.primaryFixed,
              itemLabel: "Macbook Pro M1",
              targetAmount: '₵1,499',
              currentAmount: '₵300',
              percentageProgressIndicator: 0.3,
              cardTextColor: color.onSurface,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSavingsGoalCard(
              cardColor: color.secondaryFixed,
              itemLabel: 'School Fees',
              targetAmount: '₵20,000',
              currentAmount: '₵10,000',
              percentageProgressIndicator: 0.9,
              cardTextColor: color.onSurface,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomSavingsGoalCard(
              cardColor: color.onPrimary,
              itemLabel: 'Capital',
              targetAmount: '₵30,500',
              currentAmount: '₵65,000',
              percentageProgressIndicator: 0.9,
              cardTextColor: color.surface,
            ),
            const SizedBox(
              height: 10,
            ),
            SetTimeSavingsGoalCard(
              cardColor: color.primary,
              setTimeGoal: '6 Months',
              currentAmount: '₵2,000',
              percentageProgressIndicator: 0.4,
              daysLeft: '180 days left',
              cardTextColor: color.onSurface,
              isTimeUp: false,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSavingsGoalCard extends StatelessWidget {
  const CustomSavingsGoalCard({
    super.key,
    required this.cardColor,
    required this.itemLabel,
    required this.targetAmount,
    required this.currentAmount,
    required this.percentageProgressIndicator,
    required this.cardTextColor,
  });

  final Color cardColor;
  final String itemLabel;
  final String targetAmount;
  final String currentAmount;
  final double percentageProgressIndicator;
  final Color cardTextColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    bool showCashout = percentageProgressIndicator == 1.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 13, right: 13, top: 16, bottom: 30), // Corrected padding
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
                        "$currentAmount of $targetAmount",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: cardTextColor,
                        ),
                      ),
                      // Conditional button display
                      if (showCashout)
                        ElevatedButton(
                          onPressed: () {
                            // Call Cashout Bottom Sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                              ),
                              builder: (context) {
                                return CashoutBottomSheet(
                                  amount: targetAmount,
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color.surface,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            'Cashout',
                            style: TextStyle(
                              color: color.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
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
                  const SizedBox(
                    height: 7,
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

class SetTimeSavingsGoalCard extends StatelessWidget {
  const SetTimeSavingsGoalCard({
    super.key,
    required this.cardColor,
    required this.setTimeGoal,
    required this.currentAmount,
    required this.percentageProgressIndicator,
    required this.daysLeft,
    required this.cardTextColor,
    required this.isTimeUp, // Add isTimeUp property
  });

  final Color cardColor;
  final String setTimeGoal;
  final String currentAmount;
  final double percentageProgressIndicator;
  final String daysLeft;
  final Color cardTextColor;
  final bool isTimeUp; // Flag for if time is up

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    bool showCashout = isTimeUp; // Show cashout if time is up

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 13, right: 13, top: 16, bottom: 30), // Corrected padding
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
                    setTimeGoal,
                    style: TextStyle(
                      fontSize: 18,
                      color: color.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: percentageProgressIndicator,
                    backgroundColor: color.surface.withOpacity(0.7),
                    minHeight: 5,
                    color: color.onSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentAmount,
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
                      // Conditional button display
                      if (showCashout)
                        ElevatedButton(
                          onPressed: () {
                            // Call Cashout Bottom Sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                              ),
                              builder: (context) {
                                return CashoutBottomSheet(
                                  amount: currentAmount,
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color.surface,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            'Cashout',
                            style: TextStyle(
                              color: color.onSurface, // Black text
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
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
                  const SizedBox(
                    height: 7,
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
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const StadiumBorder()),
                backgroundColor: MaterialStateProperty.all(color.primary),
              ),
              onPressed: () {
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

// CashoutBottomSheet Widget
class CashoutBottomSheet extends StatefulWidget {
  // Add amount property
  final String amount;

  const CashoutBottomSheet({Key? key, required this.amount}) : super(key: key);

  @override
  State<CashoutBottomSheet> createState() => _CashoutBottomSheetState();
}

class _CashoutBottomSheetState extends State<CashoutBottomSheet> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Prefill amount
    _amountController.text = widget.amount;
  }

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
              'Cashout', // Bottom Sheet Title
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            // Phone Number Field
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Amount Field (Prefilled and Disabled)
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              enabled: false, // Disable editing
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Reference Field
            TextField(
              controller: _referenceController,
              decoration: InputDecoration(
                hintText: 'Enter reference (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Cashout Button
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const StadiumBorder()),
                backgroundColor: MaterialStateProperty.all(color.primary),
              ),
              onPressed: () {
                // TODO: Implement cashout logic here
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                'Cashout',
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
    _phoneNumberController.dispose();
    _amountController.dispose();
    _referenceController.dispose();
    super.dispose();
  }
}
