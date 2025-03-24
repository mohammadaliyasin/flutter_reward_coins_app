// lib/domain/usecases/get_balance.dart

import '../repositories/reward_repository.dart';

class GetBalance {
  final RewardRepository repository;

  GetBalance(this.repository);

  int call() => repository.getBalance();
}