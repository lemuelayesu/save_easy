import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/consts/consts.dart';
import 'package:save_easy/consts/snackbar.dart';
import 'package:save_easy/models/news.dart';
import 'package:save_easy/models/savings_goal.dart';
import 'package:save_easy/models/user.dart';
import 'package:save_easy/providers/savings_goal_provider.dart';
import 'package:save_easy/providers/transaction_provider.dart';
import 'package:save_easy/screens/details.dart';
import 'package:save_easy/screens/news_feed.dart';
import 'package:save_easy/screens/profile.dart';
import 'package:save_easy/screens/savings_page.dart';
import 'package:save_easy/financial_news.dart';
import 'package:save_easy/savings_section.dart';
import 'package:save_easy/services/news_service.dart';
import '../providers/user_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final SavingsGoalProvider savingsGoalProvider =
        Provider.of<SavingsGoalProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: userProvider.fetchUserDetails(firebaseEmail),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshots.hasError) {
            showCustomSnackbar('Error: ${snapshots.error}', context);
            return const SizedBox();
          } else {
            User user = snapshots.data ??
                User(
                  fullName: 'fullName',
                  email: 'email',
                  phoneNumber: 'phoneNumber',
                  uid: 'uid',
                );
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const UserProfile();
                                  },
                                ),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 22,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 31.56,
                                  height: 32,
                                  child: Icon(Icons.account_circle,
                                      size: 30, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hello!",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user.fullName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(Iconsax.notification_bing5),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 16),
                              width: double.infinity,
                              height: 138,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(36, 36, 36, 20),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.9),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FutureBuilder(
                                future: transactionProvider
                                    .getTotalTransactionAmount(user),
                                builder: (context, snapshots) {
                                  if (snapshots.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshots.hasData) {
                                    double amount = snapshots.data ?? 0;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total savings',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: color.surface,
                                          ),
                                        ),
                                        Text(
                                          "GH₵ ${formatAmount(amount)}",
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: color.surface,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const Details();
                                                },
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Details',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: color.surface,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                GestureDetector(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        color.surface,
                                                    radius: 16,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_outlined,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshots.hasError) {
                                    log('Error: ${snapshots.error}');
                                    return const SizedBox();
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )),
                          Align(
                            //top right
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  'assets/illustrations/lift01.png',
                                ),
                              ),
                            ),
                          ),
                          Align(
                            //top right
                            alignment: Alignment.bottomLeft,
                            heightFactor: 4.94,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  'assets/illustrations/lift02.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Savings(user: user);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 16),
                              width: double.infinity,
                              height: 66,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(36, 36, 36, 20),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Save Now',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: color.surface,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Iconsax.add,
                                        color: color.secondary,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/illustrations/lift03.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: savingsGoalProvider.fetchCustomGoals(user.uid),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshots.hasError) {
                        log('Error: ${snapshots.error}');
                        return const SizedBox();
                      } else if (snapshots.hasData) {
                        List<CustomGoal> goals = snapshots.data ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Savings',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: color.onSurface,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Savings(
                                            user: user,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: goals.length >= 2 ? 180 : 90,
                              child: GridView.builder(
                                itemCount: goals.length >= 4 ? 4 : goals.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 10,
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  CustomGoal goal = goals[index];
                                  return SavingSection(
                                    itemLable: goal.name,
                                    priceLable:
                                        'GH₵ ${formatAmount(goal.amount)}',
                                    progressValue: goal.current > 0
                                        ? goal.current / goal.amount
                                        : 0.1,
                                    progressColor: Colors.blue,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  //News section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Financial News',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.onSurface,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const NewsPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 250,
                    child: FutureBuilder(
                      future: NewsService().loadNewsFromPreferences(),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        } else if (snapshots.hasError) {
                          log('Error: ${snapshots.hasError}');
                          return const SizedBox();
                        } else if (snapshots.hasData) {
                          List<Article> articles = snapshots.data ?? [];
                          return ListView.builder(
                            itemCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Article article = articles[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: NewsTile(
                                  headlineImage: article.imageUrl,
                                  headlineText: article.title,
                                  newsSource: article.source,
                                  url: article.articleUrl,
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
