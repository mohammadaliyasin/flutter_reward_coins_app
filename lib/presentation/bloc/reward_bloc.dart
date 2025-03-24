import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_balance.dart';
import '../../domain/usecases/scratch_card.dart';
import '../../domain/usecases/redeem_item.dart';

abstract class RewardEvent {}

class LoadBalance extends RewardEvent {}

class ScratchCardEvent extends RewardEvent {}

class RedeemItemEvent extends RewardEvent {
  final int cost;

  RedeemItemEvent(this.cost);
}

abstract class RewardState {}

class RewardInitial extends RewardState {}

class RewardLoaded extends RewardState {
  final int balance;

  RewardLoaded({required this.balance});
}

class RewardScratched extends RewardState {
  final int balance;
  final int reward;

  RewardScratched({required this.balance, required this.reward});
}

class RewardRedeemed extends RewardState {
  final int balance;
  final bool success;

  RewardRedeemed({required this.balance, required this.success});
}

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final GetBalance getBalance;
  final ScratchCard scratchCard;
  final RedeemItem redeemItem;

  // Private list to store transaction history
  final List<Map<String, dynamic>> _history = [];

  RewardBloc({
    required this.getBalance,
    required this.scratchCard,
    required this.redeemItem,
  }) : super(RewardInitial()) {
    on<LoadBalance>((event, emit) async {
      emit(RewardLoaded(balance: getBalance()));
    });

    on<ScratchCardEvent>((event, emit) async {
      final reward = scratchCard();
      final balance = getBalance();
      _addTransaction('Scratch Card', reward);
      emit(RewardScratched(balance: balance, reward: reward));
    });

    on<RedeemItemEvent>((event, emit) async {
      final success = redeemItem(event.cost);
      final balance = getBalance();
      _addTransaction('Redeem Item', -event.cost);
      emit(RewardRedeemed(balance: balance, success: success));
    });
  }

  // Method to add a transaction to the history
  void _addTransaction(String type, int amount) {
    _history.add({
      'type': type,
      'amount': amount,
      'date': DateTime.now(),
    });
  }

  // Method to retrieve the transaction history
  List<Map<String, dynamic>> getHistory() {
    return _history;
  }
}