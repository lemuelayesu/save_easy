import 'package:flutter/material.dart';
import 'package:save_easy/screens/home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // Sample data - Replace with actual user data
  final List<ChartData> chartData = [
    ChartData('Week 1', 200.0),
    ChartData('Week 2', 400.0),
    ChartData('Week 3', 600.0),
    ChartData('Week 4', 800.0),
  ];

  final List<GoalData> goalData = [
    GoalData('Month 1', 500.0),
    GoalData('Capital', 200.0),
    GoalData('New Phone', 300.0),
  ];
  List<Transaction> transactionHistory = [
    Transaction(description: 'Food', date: '2024-08-27', amount: '-GH₵100'),
    Transaction(
        description: 'Capital goal', date: '2024-08-25', amount: 'GH₵50'),
    // ... add more transaction data ...
  ];
  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: color.onSurface),
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
        ),
        title: const Center(
          child: Text('Details'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Weekly Savings Graph
              Text(
                'Weekly Savings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: color.surface,
                ),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <CartesianSeries<ChartData, String>>[
                    // Correct type here!
                    LineSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.week,
                      yValueMapper: (ChartData data, _) => data.savings,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 2. Savings Goals Pie Chart
              Text(
                'Savings Goals Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: color.surface,
                ),
                child: SfCircularChart(
                  legend: Legend(isVisible: true),
                  series: <CircularSeries<GoalData, String>>[
                    PieSeries<GoalData, String>(
                      dataSource: goalData,
                      xValueMapper: (GoalData data, _) => data.goal,
                      yValueMapper: (GoalData data, _) => data.amount,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 3. Savings Summary
              SizedBox(
                height: 120, // Adjust this height as needed
                child: Row(
                  children: [
                    Expanded(
                      // "This Month" now takes half the width
                      child: _buildSummaryBox(
                        color: color.primaryContainer,
                        title: 'This Month',
                        amount: 'GH₵1,250',
                      ),
                    ),
                    SizedBox(width: 16), // Space between tiles
                    Expanded(
                      // "Cashed Out" now takes the other half
                      child: _buildSummaryBox(
                        color: color.tertiaryContainer,
                        title: 'Cashed Out',
                        amount: 'GH₵800',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Space between rows
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: _buildSummaryBox(
                    color: const Color.fromRGBO(36, 36, 36, 20),
                    title: 'All Time',
                    amount: 'GH₵5,600',
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 4. Transactions History
              // ... (You will need to implement this part with a ListView)

              SizedBox(height: 32),
              Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color.onSurface,
                ),
              ),
              SizedBox(height: 16),
              Container(
                height:
                    200, // Set a fixed height or use Expanded for dynamic height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: color.surfaceVariant,
                ),
                child: ListView.builder(
                  itemCount:
                      transactionHistory.length, // Replace with your data
                  itemBuilder: (context, index) {
                    final transaction = transactionHistory[index];
                    return ListTile(
                      title: Text(transaction
                          .description), // Replace with transaction data
                      subtitle: Text(transaction.date),
                      trailing: Text(transaction.amount),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              // 5. Force Cashout Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color.primary,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Implement cashout logic
                    },
                    child: Text(
                      'Force Cashout',
                      style: TextStyle(fontSize: 18, color: color.surface),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create summary boxes
  Widget _buildSummaryBox({
    required Color color,
    required String title,
    required String amount,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              fontWeight: FontWeight.w500, // Slightly bolder font weight
            ),
          ),
          SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Data classes for charts
class ChartData {
  final String week;
  final double savings;

  ChartData(this.week, this.savings);
}

class GoalData {
  final String goal;
  final double amount;

  GoalData(this.goal, this.amount);
}

class Transaction {
  final String description;
  final String date;
  final String amount;

  Transaction(
      {required this.description, required this.date, required this.amount});
}
