import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/consts/consts.dart';
import 'package:save_easy/consts/snackbar.dart';
import 'package:save_easy/models/user.dart';
import 'package:save_easy/screens/profile.dart';
import 'package:save_easy/screens/savings_page.dart';
import 'package:save_easy/financial_news.dart';
import 'package:save_easy/savings_section.dart';
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
                          child: CircleAvatar(
                            radius: 22,
                            child: ClipOval(
                              child: SizedBox(
                                width: 31.56,
                                height: 32,
                                child: Image.asset(
                                    'assets/illustrations/circleavatar.png'),
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
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Savings();
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
                const SizedBox(
                  height: 5,
                ),
                const NewsTile(
                  headlineImage: 'assets/pictures/gatetomars.jpeg',
                  headlineText:
                      'This is the time to invest in a space Company as the race to the moon becomes firce',
                  newsSource: 'The news Times',
                ),
                const NewsTile(
                  headlineImage: 'assets/pictures/saveeasy.png',
                  headlineText:
                      'The launch of a new micro-savings platform goes viral. People say it is just what they are looking for.',
                  newsSource: 'The Easy Times',
                ),
              ],
            ),
          );
        }
      },
    ));
  }
}
