// lib/domain/usecases/redeem_item.dart

import '../repositories/reward_repository.dart';

class RedeemItem {
  final RewardRepository repository;

  RedeemItem(this.repository);

  bool call(int cost) => repository.redeemItem(cost);
}