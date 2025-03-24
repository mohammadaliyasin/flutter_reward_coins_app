// lib/data/datasources/mock_data_source.dart

class MockDataSource {
  int _balance = 1000; // Initial balance
  final List<Map<String, dynamic>> _history = [];

  int getBalance() => _balance;

  int scratchCard() {
    final reward = 50 + (DateTime.now().millisecondsSinceEpoch % 451); // Random reward between 50 and 500
    _balance += reward;
    _history.add({
      'type': 'Scratch Card Reward',
      'amount': reward,
      'date': DateTime.now(),
    });
    return reward;
  }

  bool redeemItem(int cost) {
    if (_balance >= cost) {
      _balance -= cost;
      _history.add({
        'type': 'Redeemed Item',
        'amount': -cost,
        'date': DateTime.now(),
      });
      return true;
    }
    return false;
  }

  List<Map<String, dynamic>> getHistory() => _history;
}