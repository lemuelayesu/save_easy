import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/screens/savings_page.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

import '../consts/snackbar.dart';
import '../models/notification.dart' as n;
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../services/notification_service.dart';
import '../services/payment_service.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView(
      {super.key,
      required this.transaction,
      required this.savingsType,
      required this.currentAmount});

  final Transaction transaction;
  final String savingsType;
  final double currentAmount;

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late Future futureInitTransaction;
  late final PlatformWebViewControllerCreationParams params;

  @override
  void initState() {
    super.initState();
    futureInitTransaction =
        PaystackService().initTransaction(widget.transaction, context);
    params = const PlatformWebViewControllerCreationParams();
  }

  String formatAmount(double amount) {
    final formatter = NumberFormat("#,##0.00", "en_UK");
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: color.onSurface,
            size: 20,
          ),
        ),
        title: Text(
          'Complete Payment',
          style: TextStyle(
            color: color.onSurface,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: futureInitTransaction,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final url = snapshot.data ?? 'https://flutter.dev';
              return WebViewWidget(
                controller: WebViewController.fromPlatformCreationParams(params)
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setBackgroundColor(color.surface)
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onProgress: (int progress) {},
                      onPageStarted: (String url) {},
                      onPageFinished: (String url) {},
                      onWebResourceError: (WebResourceError error) {},
                      onNavigationRequest: (NavigationRequest request) {
                        if (request.url
                            .startsWith('https://www.youtube.com/')) {
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                    ),
                  )
                  ..loadRequest(
                    Uri.parse(url!),
                  ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () async {
          bool isVerified = await PaystackService()
              .verifyTransaction(widget.transaction, context);
          if (isVerified == true) {
            transactionProvider.saveTransaction(widget.transaction);
            n.Notification notification = n.Notification(
              title: 'Transaction completed',
              body:
                  'Your payment of GHc ${formatAmount(widget.transaction.amount)} to SaveEasy has been completed.',
              date: widget.transaction.date,
              uid: widget.transaction.uid,
              id: const Uuid().v4(),
            );
            await NotificationService.showInstantNotification(notification);
            if (widget.savingsType == 'custom') {
              await transactionProvider.updateCustomAmount(
                  widget.transaction.goalId,
                  widget.currentAmount,
                  widget.transaction.amount);
            } else {
              await transactionProvider.updateTimedAmount(
                  widget.transaction.goalId,
                  widget.currentAmount,
                  widget.transaction.amount);
            }
            showCustomSnackbar(
              'Transaction completed successfully',
              context,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Homepage();
                },
              ),
            );
          } else if (isVerified == false) {
            showCustomSnackbar('Transaction could not be verified', context);
          } else {
            showCustomSnackbar(
                'An error occurred during transaction verification', context);
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.primary,
          ),
          child: const Text(
            'Transaction Completed',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
