import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/consts/consts.dart';
import 'package:save_easy/consts/snackbar.dart';
import 'package:save_easy/models/user.dart';
import 'package:save_easy/screens/savings.dart';

import '../providers/user_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 31.56,
                            height: 32,
                            child: Image.asset(
                                'assets/illustrations/circleavatar.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Good Morning!",
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
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                "₵25,000.40",
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
                                        return const Savings();
                                      },
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'My savings',
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
                                          backgroundColor: color.surface,
                                          radius: 16,
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_forward_outlined,
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
                          ),
                        ),
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
                      //for this button
                      //Big plus sign to save
                      //After clicking on there, users can pick a plan or create a new one and upload money to it.
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Savings();
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
                    const TextButton(
                      onPressed: null,
                      child: Text(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //savings section
                  children: [
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        SavingSection(
                          progressColor: color.secondary,
                          itemLable: 'Iphone 13 Mini',
                          priceLable: '₵699',
                          progressValue: 0.5,
                        ),
                        //const SizedBOx
                        SavingSection(
                          itemLable: 'Macbook Pro M1',
                          priceLable: '₵1,499',
                          progressValue: 0.6,
                          progressColor: color.secondaryFixed,
                        ),
                        SavingSection(
                          itemLable: 'Car',
                          priceLable: '₵20,000',
                          progressValue: 0.3,
                          progressColor: color.primaryFixed,
                        ),
                        SavingSection(
                          itemLable: 'House',
                          priceLable: '₵30,500',
                          progressValue: 0.55,
                          progressColor: color.primary,
                        ),
                      ],
                    ),
                  ],
                ),
                //News section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fiancial News',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color.onSurface,
                      ),
                    ),
                    const TextButton(
                      onPressed: null,
                      child: Text(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                        height: 100.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: color.surface,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 110,
                              height: 100,
                              child: Image.asset(
                                'assets/pictures/gatetomars.jpeg',
                                fit: BoxFit.fitHeight,
                              ),
                            ),

                            //Column(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    ));
  }
}

class SavingSection extends StatelessWidget {
  const SavingSection({
    super.key,
    required this.itemLable,
    required this.priceLable,
    required this.progressValue,
    required this.progressColor,
  });

  final Color progressColor;
  final String itemLable;
  final String priceLable;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      width: 156,
      height: 91,
      padding: const EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemLable,
                style: TextStyle(
                  color: color.tertiary,
                  fontSize: 13,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            priceLable,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: color.surfaceDim,
            minHeight: 8,
            color: progressColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
