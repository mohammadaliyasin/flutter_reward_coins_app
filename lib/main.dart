import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reward_coins_app/domain/usecases/get_balance.dart';
import 'package:flutter_reward_coins_app/domain/usecases/redeem_item.dart';
import 'package:flutter_reward_coins_app/domain/usecases/scratch_card.dart';
import 'data/repositories/reward_repository_impl.dart';
import 'presentation/bloc/reward_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => RewardBloc(
          getBalance: GetBalance(RewardRepositoryImpl()),
          scratchCard: ScratchCard(RewardRepositoryImpl()),
          redeemItem: RedeemItem(RewardRepositoryImpl()),
        )..add(LoadBalance()),
        child: HomeScreen(),
      ),
    );
  }
}