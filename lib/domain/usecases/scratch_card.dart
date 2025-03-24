// lib/domain/usecases/scratch_card.dart

import '../repositories/reward_repository.dart';

class ScratchCard {
  final RewardRepository repository;

  ScratchCard(this.repository);

  int call() => repository.scratchCard();
}