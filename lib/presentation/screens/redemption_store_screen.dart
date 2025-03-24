import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';

class RedemptionStoreScreen extends StatelessWidget {
  // List of redeemable items with their names and costs
  final List<Map<String, dynamic>> redeemableItems = [
    {'name': 'Discount Coupon', 'cost': 300},
    {'name': 'Gift Card', 'cost': 500},
    {'name': 'Free Coffee', 'cost': 100},
    {'name': 'Movie Ticket', 'cost': 400},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redemption Store'),
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardLoaded) {
            final balance = state.balance;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Balance: $balance coins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: redeemableItems.length,
                    itemBuilder: (context, index) {
                      final item = redeemableItems[index];
                      final itemName = item['name'];
                      final itemCost = item['cost'];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(itemName),
                          subtitle: Text('Cost: $itemCost coins'),
                          trailing: ElevatedButton(
                            onPressed: balance >= itemCost
                                ? () {
                                    // Attempt to redeem the item
                                    context.read<RewardBloc>().add(RedeemItemEvent(itemCost));
                                  }
                                : null, // Disable button if balance is insufficient
                            child: Text('Redeem'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is RewardScratched) {
            final balance = state.balance;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Balance: $balance coins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: redeemableItems.length,
                    itemBuilder: (context, index) {
                      final item = redeemableItems[index];
                      final itemName = item['name'];
                      final itemCost = item['cost'];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(itemName),
                          subtitle: Text('Cost: $itemCost coins'),
                          trailing: ElevatedButton(
                            onPressed: balance >= itemCost
                                ? () {
                                    // Attempt to redeem the item
                                    context.read<RewardBloc>().add(RedeemItemEvent(itemCost));
                                  }
                                : null, // Disable button if balance is insufficient
                            child: Text('Redeem'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is RewardRedeemed) {
            final balance = state.balance;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Balance: $balance coins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: redeemableItems.length,
                    itemBuilder: (context, index) {
                      final item = redeemableItems[index];
                      final itemName = item['name'];
                      final itemCost = item['cost'];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(itemName),
                          subtitle: Text('Cost: $itemCost coins'),
                          trailing: ElevatedButton(
                            onPressed: balance >= itemCost
                                ? () {
                                    // Attempt to redeem the item
                                    context.read<RewardBloc>().add(RedeemItemEvent(itemCost));
                                  }
                                : null, // Disable button if balance is insufficient
                            child: Text('Redeem'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}