// lib/domain/repositories/reward_repository.dart

abstract class RewardRepository {
  /// Returns the current coin balance of the user.
  int getBalance();

  /// Simulates scratching a card and returns the reward amount.
  /// The reward is a random value between 50 and 500 coins.
  int scratchCard();

  /// Attempts to redeem an item with the given cost.
  /// Returns `true` if the redemption is successful (user has enough coins),
  /// otherwise returns `false`.
  bool redeemItem(int cost);

  /// Returns the transaction history of the user.
  /// Each transaction is represented as a map with keys:
  /// - 'type': The type of transaction (e.g., "Scratch Card Reward", "Redeemed Item").
  /// - 'amount': The amount of coins gained or spent.
  /// - 'date': The date and time of the transaction.
  List<Map<String, dynamic>> getHistory();
}