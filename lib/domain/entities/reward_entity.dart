// lib/domain/entities/reward_entity.dart

class RewardEntity {
  final int balance;
  final List<Map<String, dynamic>> history;

  RewardEntity({required this.balance, required this.history});
}