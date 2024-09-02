import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/consts/consts.dart';
import 'package:save_easy/consts/snackbar.dart';
import 'package:save_easy/models/transaction.dart';
import 'package:save_easy/models/user.dart';
import 'package:save_easy/providers/savings_goal_provider.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/screens/payment_webview.dart';
import 'package:save_easy/widgets/set_savings_goal.dart';
import 'package:uuid/uuid.dart';
import '../models/savings_goal.dart';

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
    final SavingsGoalProvider savingsGoalProvider =
        Provider.of<SavingsGoalProvider>(context, listen: false);
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
            Text('Custom Goals'),
            FutureBuilder(
              future: savingsGoalProvider.fetchCustomGoals(widget.user.uid),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshots.hasError) {
                  showCustomSnackbar('Error: ${snapshots.error}', context);
                  log('Error: ${snapshots.error}');
                  return const SizedBox();
                } else if (snapshots.hasData) {
                  final List<CustomGoal> customGoals = snapshots.data ?? [];

                  return customGoals.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: customGoals.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              CustomGoal goal = customGoals[index];
                              double current = goal.current;
                              double target = goal.amount;
                              double progress = current / target;
                              double percentage = progress * 100;
                              return SavingGoalCard(
                                cardColor: Colors.blue,
                                itemLabel: goal.name,
                                currentAmount: goal.current,
                                percentageProgressIndicator:
                                    percentage.ceilToDouble(),
                                cardTextColor: Colors.white,
                                uid: widget.user.uid,
                                goalId: goal.id,
                              );
                            },
                          ),
                        );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const Text('Set Time Goals'),
            FutureBuilder(
              future: savingsGoalProvider.fetchTimedGoals(widget.user.uid),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshots.hasError) {
                  showCustomSnackbar('Error: ${snapshots.error}', context);
                  log('Error: ${snapshots.error}');
                  return const SizedBox();
                } else if (snapshots.hasData) {
                  final List<TimedGoal> timedGoals = snapshots.data ?? [];

                  return timedGoals.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: timedGoals.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              TimedGoal goal = timedGoals[index];
                              //supposed to calculate the days that pass after
                              //and give the days left
                              int months = goal.months;
                              DateTime startDate = goal.startDate;
                              int totalDays = months * 31;
                              int daysPassed =
                                  DateTime.now().difference(startDate).inDays;
                              int daysLeft = totalDays - daysPassed;
                              if (daysLeft < 0) {
                                daysLeft = 0;
                              }
                              double progress =
                                  (totalDays - daysLeft).toDouble() / totalDays;
                              double percentage = progress * 100;

                              return SetTimeSavingsGoalCard(
                                cardColor: color.secondary,
                                cardTextColor: Colors.white,
                                months: goal.months,
                                daysLeft: daysLeft.toString(),
                                currentAmount: goal.current,
                                percentageProgressIndicator: percentage,
                                uid: widget.user.uid,
                                goalId: goal.id,
                              );
                            },
                          ),
                        );
                } else {
                  return const SizedBox();
                }
              },
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
    required this.currentAmount,
    required this.percentageProgressIndicator,
    required this.cardTextColor,
    required this.uid,
    required this.goalId,
  });

  final Color cardColor;
  final String itemLabel;
  final double currentAmount;
  final double percentageProgressIndicator;
  final Color cardTextColor;
  final String uid;
  final String goalId;

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
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
                          "Progress",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: color.surface,
                          ),
                        ),
                        Text(
                          "${percentageProgressIndicator.toStringAsFixed(0)}%",
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
                      value: percentageProgressIndicator / 100,
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
                          'GHc ${formatAmount(currentAmount)}',
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
                              return AddSavingsBottomSheet(
                                uid: uid,
                                goalId: goalId,
                                savingsType: 'custom',
                              );
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
      ),
    );
  }
}

class SetTimeSavingsGoalCard extends StatelessWidget {
  const SetTimeSavingsGoalCard({
    super.key,
    required this.cardColor,
    required this.months,
    required this.currentAmount,
    required this.percentageProgressIndicator,
    required this.daysLeft,
    required this.cardTextColor,
    required this.uid,
    required this.goalId,
  });

  final Color cardColor;
  final int months;
  final double currentAmount;
  final double percentageProgressIndicator;
  final String daysLeft;
  final Color cardTextColor;
  final String uid;
  final String goalId;

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
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
                      'Set Time ($months months)',
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
                          "Progress",
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
                          'GHc ${formatAmount(currentAmount)}',
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
                              return AddSavingsBottomSheet(
                                uid: uid,
                                goalId: goalId,
                                savingsType: 'timed',
                              );
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
        ),
      ],
    );
  }
}

class AddSavingsBottomSheet extends StatefulWidget {
  const AddSavingsBottomSheet(
      {super.key,
      required this.uid,
      required this.goalId,
      required this.savingsType});

  final String uid;
  final String goalId;
  final String savingsType;

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
                shape: WidgetStateProperty.all(const StadiumBorder()),
                backgroundColor: WidgetStateProperty.all(color.primary),
              ),
              onPressed: () {
                //take amount
                double amount = double.parse(_amountController.text);
                Transaction transaction = Transaction(
                    id: const Uuid().v4(),
                    uid: widget.uid,
                    goalId: widget.goalId,
                    amount: amount,
                    date: DateTime.now(),
                    isDebit: true);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PaymentWebView(
                      transaction: transaction,
                      currentAmount: transaction.amount,
                      savingsType: widget.savingsType,
                    );
                  }),
                );
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
    _amountController.dispose();
    super.dispose();
  }
}
