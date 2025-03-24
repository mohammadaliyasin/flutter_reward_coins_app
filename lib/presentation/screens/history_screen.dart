import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          final history = context.read<RewardBloc>().getHistory();

          if (history.isEmpty) {
            return Center(
              child: Text(
                'No transactions yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final transaction = history[index];
              final type = transaction['type'];
              final amount = transaction['amount'];
              final date = transaction['date'];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(type),
                  subtitle: Text(
                    'Amount: ${amount > 0 ? "+$amount" : amount} coins\nDate: ${date.toLocal()}',
                  ),
                  trailing: Icon(
                    amount > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                    color: amount > 0 ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}