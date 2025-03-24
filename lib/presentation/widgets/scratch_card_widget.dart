// lib/presentation/widgets/scratch_card_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';

class ScratchCardWidget extends StatefulWidget {
  @override
  _ScratchCardWidgetState createState() => _ScratchCardWidgetState();
}

class _ScratchCardWidgetState extends State<ScratchCardWidget> {
  List<Offset> _points = []; // Stores the points where the user has "scratched"
  bool _isScratched = false; // Tracks whether the card has been sufficiently scratched
  int _reward = 0; // Stores the reward value
  double _scratchPercentage = 0.0; // Tracks the percentage of the card scratched

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Check if the touch is within the scratch card bounds
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);

        // Scratch card dimensions
        final cardWidth = 200.0;
        final cardHeight = 100.0;

        // Only add points if they are within the scratch card bounds
        if (localPosition.dx >= 0 &&
            localPosition.dx <= cardWidth &&
            localPosition.dy >= 0 &&
            localPosition.dy <= cardHeight) {
          setState(() {
            _points = List.from(_points)..add(localPosition);
            _scratchPercentage = (_points.length / 50).clamp(0.0, 1.0); // Update scratch percentage
          });
        }
      },
      onPanEnd: (details) {
        // When the user stops scratching, check if enough area has been scratched
        if (_points.length > 20 && !_isScratched) {
          // Trigger the scratch card event in the BLoC
          final rewardBloc = context.read<RewardBloc>();
          rewardBloc.add(ScratchCardEvent());

          // Get the reward value from the state
          final state = rewardBloc.state;
          if (state is RewardScratched) {
            setState(() {
              _reward = state.reward; // Store the reward value
              _isScratched = true; // Mark the card as scratched
            });
          }
        }
      },
      child: Stack(
        children: [
          // The reward content (hidden underneath)
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _isScratched
                  ? Text(
                      'You won $_reward coins!',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      _scratchPercentage > 0
                          ? '${(_reward * (1 - _scratchPercentage)).toInt()}'
                          : 'Scratch to reveal your reward!',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          // The scratchable layer (only visible if not fully scratched)
          if (!_isScratched)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomPaint(
                size: Size(200, 100),
                painter: ScratchPainter(_points),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom painter to draw the scratch effect
class ScratchPainter extends CustomPainter {
  final List<Offset> points;

  ScratchPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // Draw the scratches based on the user's touch points
    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}