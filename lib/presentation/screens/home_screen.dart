// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';
import '../widgets/scratch_card_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reward Coins'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to the History Screen
              Navigator.pushNamed(context, '/history');
            },
          ),
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              // Navigate to the Redemption Store Screen
              Navigator.pushNamed(context, '/redemption');
            },
          ),
        ],
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Balance: ${state.balance} coins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ScratchCardWidget(),
                  ),
                ),
              ],
            );
          } else if (state is RewardScratched) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Balance: ${state.balance} coins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScratchCardWidget(),
                        SizedBox(height: 20),
                        Text(
                          'You earned ${state.reward} coins!',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is RewardRedeemed) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Balance: ${state.balance} coins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScratchCardWidget(),
                        SizedBox(height: 20),
                        Text(
                          state.success ? 'Redemption Successful!' : 'Insufficient Coins',
                          style: TextStyle(
                            fontSize: 16,
                            color: state.success ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
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