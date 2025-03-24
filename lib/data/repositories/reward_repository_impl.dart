// lib/data/repositories/reward_repository_impl.dart

import '../../domain/repositories/reward_repository.dart';
import '../datasources/mock_data_source.dart';

class RewardRepositoryImpl implements RewardRepository {
  final MockDataSource _dataSource = MockDataSource();

  @override
  int getBalance() => _dataSource.getBalance();

  @override
  int scratchCard() => _dataSource.scratchCard();

  @override
  bool redeemItem(int cost) => _dataSource.redeemItem(cost);

  @override
  List<Map<String, dynamic>> getHistory() => _dataSource.getHistory();
}